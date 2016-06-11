//
//  APIManager.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

public class APIManager {
    
    public class var sharedInstance: APIManager {
        struct Singleton {
            static let instance : APIManager = APIManager()
        }
        return Singleton.instance
    }
    
    let manager = Manager()
    
    init() {
    }
    
    // MARK: Login API
    
    func getSession(email: String, password: String, completion: (session: Session?, error: NSError?) -> ()) -> Request {
        let router = SessionRouter(endpoint: SessionEndpoint.GetToken(email: email, password: password))
        
        //validate codes including those from API for custom errors
        let validStatusCodes: Range<Int> = 200...403
        return manager.request(router)
            .validate(statusCode: validStatusCodes)
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                let statusCode:Int = (response.response?.statusCode)!
                
                NSLog("STATUS CODE: \(statusCode)")
                
                switch statusCode {
                case 200 ... 299:
                    NSLog("API Success")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    var object:Session!
                    
                    NSLog("JSON: \(jsonData)")
                    
                    //save Session Object to Realm DB
                    let realm = try! Realm()
                    do {
                        try realm.write() {
                            object = Session(json: jsonData)
                            object.email = email
                            
                            realm.add(object, update: true)
                            NSLog("SESSION: \(object)")
                            NSLog("TOKEN: \(object.accessToken)")
                            NSLog("EMAIL: \(object.email)")
                            
                            //save token to user defaults for quick access on API requests and autologin
                            NSUserDefaults.standardUserDefaults().setObject(object.accessToken, forKey: "accessToken")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            
                            completion(session: object, error: nil)
                            
                        }
                    } catch let error as NSError  {
                        NSLog("Error Saving to DB: \(error), \(error.userInfo)")
                        
                        completion(session: nil, error: error)
                    }
                    
                case 400 ... 403:
                    NSLog("API failure")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    NSLog("JSON: \(jsonData)")
                    
                    let error:NSError = ErrorManager.parseErrorWithJSON(jsonData)!
                    
                    //handle custom error on completion
                    completion(session: nil, error: error)
                    return
                    
                default:
                    NSLog("Default failures")
                    
                    if let error = response.result.error {
                        NSLog("Error: %s", error.localizedDescription)
                        
                        //handle default error
                        completion(session: nil, error: error)
                        return
                    }
                }
            })
    }
    
    // MARK: Signup API
    
    func register(email: String, password: String, completion: (session: Session?, error: NSError?) -> ()) -> Request {
        let router = SessionRouter(endpoint: SessionEndpoint.Register(email: email, password: password))
        
        //validate codes including those from API for custom errors
        let validStatusCodes: Range<Int> = 200...403
        return manager.request(router)
            .validate(statusCode: validStatusCodes)
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                let statusCode:Int = (response.response?.statusCode)!
                
                NSLog("STATUS CODE: \(statusCode)")
                
                switch statusCode {
                case 200 ... 299:
                    NSLog("API Success")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    var object:Session!
                    
                    NSLog("JSON: \(jsonData)")
                    
                    //save Session Object to Realm DB
                    let realm = try! Realm()
                    do {
                        try realm.write() {
                            object = Session(json: jsonData)
                            object.email = email
                            
                            realm.add(object, update: true)
                            NSLog("SESSION: \(object)")
                            NSLog("TOKEN: \(object.accessToken)")
                            NSLog("EMAIL: \(object.email)")
                            
                            //save token to user defaults for quick access on API requests and autologin
                            NSUserDefaults.standardUserDefaults().setObject(object.accessToken, forKey: "accessToken")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            
                            completion(session: object, error: nil)
                            
                        }
                    } catch let error as NSError  {
                        NSLog("Error Saving to DB: \(error), \(error.userInfo)")
                        
                        completion(session: nil, error: error)
                    }
                    
                case 400 ... 403:
                    NSLog("API failure")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    NSLog("JSON: \(jsonData)")
                    
                    let error:NSError = ErrorManager.parseErrorWithJSON(jsonData)!
                    
                    //handle custom error on completion
                    completion(session: nil, error: error)
                    return
                    
                default:
                    NSLog("Default failures")
                    
                    if let error = response.result.error {
                        NSLog("Error: %s", error.localizedDescription)
                        
                        //handle default error
                        completion(session: nil, error: error)
                        return
                    }
                }
            })
    }
    
    // MARK: Places API
    
    func getPlaces(completion: (places: [Place], error: NSError?) -> ()) -> Request {
        let router = PlaceRouter(endpoint: PlaceEndpoint.GetPlaces())
        
        //validate codes including those from API for custom errors
        let validStatusCodes: Range<Int> = 200...403
        return manager.request(router)
            .validate(statusCode: validStatusCodes)
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                let statusCode:Int = (response.response?.statusCode)!
                
                NSLog("STATUS CODE: \(statusCode)")
                
                switch statusCode {
                case 200 ... 299:
                    NSLog("API Success")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    NSLog("JSON: \(jsonData)")
                    
                    if let results = jsonData["results"] as? [JSONDictionary] {

                        var objects:[Place] = []
                        
                        NSLog("JSON: \(results)")
                        
                        //save Session Object to Realm DB
                        let realm = try! Realm()
                        do {
                            try realm.write() {
                                
                                for item in results {
                                
                                    let object = Place(json: item)
                                    
                                    realm.add(object, update: true)
                                    
                                    NSLog("PLACE: \(object)")
                                    NSLog("ID: \(object.id)")
                                    NSLog("NAME: \(object.name)")
                                    NSLog("LAT: \(object.lat)")
                                    NSLog("LNG: \(object.lng)")
                                    
                                    objects += [object]
                                    
                                }
                                
                                completion(places: objects, error: nil)
                                
                            }
                        } catch let error as NSError  {
                            NSLog("Error Saving to DB: \(error), \(error.userInfo)")
                            
                            completion(places: [], error: error)
                        }
                        
                    }
                    

                    
                case 400 ... 403:
                    NSLog("API failure")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    NSLog("JSON: \(jsonData)")
                    
                    let error:NSError = ErrorManager.parseErrorWithJSON(jsonData)!
                    
                    //handle custom error on completion
                    completion(places: [], error: error)
                    return
                    
                default:
                    NSLog("Default failures")
                    
                    if let error = response.result.error {
                        NSLog("Error: %s", error.localizedDescription)
                        
                        //handle default error
                        completion(places: [], error: error)
                        return
                    }
                }
            })
    }
    
    
    // MARK: Payment API
    
    func payment(number: String, name: String, exp: String, code: String, completion: (message: String, error: NSError?) -> ()) -> Request {
        let router = PaymentRouter(endpoint: PaymentEndpoint.Payment(number: number, name: name, exp: exp, code: code))
        
        //validate codes including those from API for custom errors
        let validStatusCodes: Range<Int> = 200...403
        return manager.request(router)
            .validate(statusCode: validStatusCodes)
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                let statusCode:Int = (response.response?.statusCode)!
                
                NSLog("STATUS CODE: \(statusCode)")
                
                switch statusCode {
                case 200 ... 299:
                    NSLog("API Success")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    NSLog("JSON: \(jsonData)")
                    
                    let message:String = jsonData["message"] as! String
                    NSLog("MESSAGE: \(message)")
                    
                    completion(message: message, error: nil)
                    
                case 400 ... 403:
                    NSLog("API failure")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
                    NSLog("JSON: \(jsonData)")
                    
                    let error:NSError = ErrorManager.parseErrorWithJSON(jsonData)!
                    
                    //handle custom error on completion
                    completion(message: "", error: error)
                    return
                    
                default:
                    NSLog("Default failures")
                    
                    if let error = response.result.error {
                        NSLog("Error: %s", error.localizedDescription)
                        
                        //handle default error
                        completion(message: "", error: error)
                        return
                    }
                }
            })
    }
}
