//
//  ErrorManager.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import UIKit

// ErrorManager Singleton class
// To handle custom errors

//Error Codes Enum
enum ErrorCodeType: Int, CustomStringConvertible {
    case Code_00000 = 0000
    case Code_0001A = 5001
    case Code_0001B = 5002
    case Code_0001C = 5003
    
    var value: Int {
        return self.rawValue
    }
    
    var description: String {
        switch self {
        case .Code_00000: return "00000"
        case .Code_0001A: return "0001A"
        case .Code_0001B: return "0001B"
        case .Code_0001C: return "0001C"
        }
    }
    
    static func getErrorCodeType(code: String) -> ErrorCodeType {
        switch code {
        case "00000": return .Code_00000
        case "0001A": return .Code_0001A
        case "0001B": return .Code_0001B
        case "0001C": return .Code_0001C
        default: return .Code_00000
        }
    }
}

class ErrorManager: NSObject {
    
    var errorTitle:String!
    var errorMessage:String!
    var errorCodeType:ErrorCodeType!
    var errorCode:Int!
    var cancelButtonTitle:String!
    
    /// Singleton instance
    class var shared: ErrorManager {
        get{
            struct StaticObject {
                static var instance: ErrorManager? = nil
                static var onceToken: dispatch_once_t = 0
            }
            
            dispatch_once(&StaticObject.onceToken) {
                StaticObject.instance = ErrorManager()
                StaticObject.instance?.errorCodeType = ErrorCodeType.Code_00000
                StaticObject.instance?.errorCode = 0
                StaticObject.instance?.errorTitle = "Error"
                StaticObject.instance?.errorMessage = "Undefined Error"
                StaticObject.instance?.cancelButtonTitle = "OK"
            }
            return StaticObject.instance!
        }
    }
    
    class func parseErrorWith(error: NSError!) -> NSError? {
        
        if error != nil && error.localizedRecoverySuggestion != nil {
            let data:NSData = error.localizedRecoverySuggestion!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
            
            do {
                let errorJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                
                NSLog("ERROR JSON: \(errorJSON)")
                
                if let json = errorJSON as? JSONDictionary,
                    let message = json["message"] as AnyObject? as? String,
                    let code = json["code"] as AnyObject? as? String {
                    
                    print("CODE: \(code)")
                    print("MESSAGE: \(message)")
                    
                    self.shared.errorCodeType = ErrorCodeType.getErrorCodeType(code)
                    self.shared.errorCode = self.shared.errorCodeType.value
                    self.shared.errorMessage = message
                    
                    let newError:NSError = NSError(domain: "com.crossover.Jitensha.NewError", code: self.shared.errorCode, userInfo: [NSLocalizedDescriptionKey:message])
                    
                    return newError
                }
            } catch let error as NSError  {
                print("Could not handle Custom Error \(error), \(error.userInfo)")
                return nil
            }
        }
        return nil
    }
    
    
    class func parseErrorWithJSON(json: JSONDictionary?) -> NSError? {
        
        if let JSON = json {
            NSLog("ERROR JSON: \(JSON)")
            
            if let message = JSON["message"] as AnyObject? as? String,
                let code = JSON["code"] as AnyObject? as? String {
                
                print("CODE: \(code)")
                print("MESSAGE: \(message)")
                
                self.shared.errorCodeType = ErrorCodeType.getErrorCodeType(code)
                self.shared.errorCode = self.shared.errorCodeType.value
                self.shared.errorMessage = message
                
                let newError:NSError = NSError(domain: "com.crossover.Jitensha.Error", code: self.shared.errorCode, userInfo: [NSLocalizedDescriptionKey:message])
                
                return newError
            }
        }
        
        return nil
    }
    
    class func handleError(error: NSError?) {
        if error != nil {
            //setup error map by codes
            self.internalErrorMap(error!)
        }
    }
    
    class func defaultErrorMap(error: NSError) -> Void {
        
        self.shared.errorCode = error.code
        
        //map code errors as required
        switch error.code {
        case 404...499: //set all default errors
            self.shared.errorTitle = "Error, Something went wrong!"
            self.shared.errorMessage = "Sorry for the trouble! We'll take a look right away. Please try again later."
            self.shared.cancelButtonTitle = "OK"
        default:
            self.shared.errorTitle = "Error"
            self.shared.errorMessage = error.localizedDescription
            self.shared.cancelButtonTitle = "OK"
        }
        
        print("ERROR CODE: \(ErrorManager.shared.errorCode)")
        print("ERROR TITLE: \(ErrorManager.shared.errorTitle)")
        print("ERROR MESSAGE: \(ErrorManager.shared.errorMessage)")
    }
    
    class func internalErrorMap(error: NSError) -> Void {
        
        self.shared.errorCode = error.code
        
        //map internal server errors as required
        switch error.code {
        case ErrorCodeType.Code_0001A.rawValue: //JSON Error
            self.shared.errorTitle = "Invalid JSON format"
            self.shared.errorMessage = "The current JSON format request is wrong. Please fix and try again."
            self.shared.cancelButtonTitle = "OK"
        case ErrorCodeType.Code_0001B.rawValue: //Credentials Error
            self.shared.errorTitle = "Invalid Credentials"
            self.shared.errorMessage = "The email/password is wrong. Please fix and try again."
            self.shared.cancelButtonTitle = "OK"
        case ErrorCodeType.Code_0001C.rawValue: //AccessToken Error
            self.shared.errorTitle = "Invalid AccessToken"
            self.shared.errorMessage = "The current AccessToken is invalid. Please authenticate and try again."
            self.shared.cancelButtonTitle = "OK"
        default:
            self.defaultErrorMap(error)
        }
        
        print("ERROR CODE: \(ErrorManager.shared.errorCode)")
        print("ERROR TITLE: \(ErrorManager.shared.errorTitle)")
        print("ERROR MESSAGE: \(ErrorManager.shared.errorMessage)")
    }
    
    class func errorAlertController(error: NSError, complete:(()->())! = nil) -> UIAlertController {
        
        //setup error correctly
        self.handleError(error)
        
        var message:String!
        var title:String!
        
        //IMPORTANT: avoid hard-code by message, just update by error code on internalErrorMap
        title = ErrorManager.shared.errorTitle
        message = ErrorManager.shared.errorMessage
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action :UIAlertAction = UIAlertAction(title: ErrorManager.shared.cancelButtonTitle, style: .Destructive, handler: { (action: UIAlertAction!) -> Void in
            if complete != nil {
                complete()
            }
            ()
        })
        
        alert.addAction(action)
        
        return alert
    }
    
}