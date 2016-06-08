//
//  APIManager.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
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
    
    //MARK: API Methods
    
    func getArticles(page: Int = 1, completion: (articles: [Article]) -> ()) -> Request {
        let router = ArticleRouter(endpoint: .GetArticles(page: page))
        
        return manager.request(router)
            .validate()
            .responseJSON(completionHandler: {
                (response) -> Void in
            
                if let error = response.result.error {
                    print(error)
                    return;
                }
                
                let articlesJSON = ((response.result.value as! JSONDictionary)["articles"] as? [JSONDictionary])!
                
                var objs: [Article] = []
                
                NSLog("ARTICLES JSON: \(articlesJSON)")
                
                let realm = try! Realm()
                do {
                    try realm.write() {
                        for item in articlesJSON {
                            let object = Article(json: item)
//                            let newarticle = realm.create(Article.self, value: item)
                            realm.add(object, update: true)
                            
                            objs += [object]
                            
                        }
                    }
                } catch let error as NSError  {
                    print("Error \(error), \(error.userInfo)")
                }
                
//                //Create Realm Objects
//                let realm = try! Realm()
//                try! realm.write {
//                    for article in articles {
//                        let newarticle = realm.create(Article.self, value: article)
//                        objs += [newarticle]
//                    }
//                }
                
                NSLog("ARTICLES: \(objs)")
                
                completion(articles: objs)
        })
    }
    
    //REST-API: fetch data
    class func fetch(completion: (([AnyObject], error: NSError?) -> Void)) {
        
        let result:[AnyObject] = []
        
        //TODO: implement Alamofire router/callbacks here
        
        //complete empty for now
        completion(result, error: nil)
        
    }
    
    
}
