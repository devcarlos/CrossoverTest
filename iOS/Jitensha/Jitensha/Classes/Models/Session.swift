//
//  Session.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

private let TOKEN_KEY = "accessToken"
private let EMAIL_KEY = "email"

//Session Model Class
public class Session: Object {
    
    //MARK : Properties
    
    dynamic var email: String = ""
    dynamic var accessToken: String = ""
    
    //MARK : init functions
    
    required public init() {
        super.init()
    }
    
    convenience init(json: JSONDictionary) {
        self.init()
        populateWithJSON(json)
    }
    
    //MARK : Realm initializers
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    
    override public class func primaryKey() -> String? {
        return EMAIL_KEY
    }
    
    //MARK : JSON Parse Functions
    
    func populateWithJSON(dictionary: JSONDictionary) {
        if let token = dictionary[TOKEN_KEY] as? String {
            self.accessToken = token
        }
        
        if let email = dictionary[EMAIL_KEY] as? String {
            self.email = email
        }
        
    }
    
    func toJsonDictionary() -> JSONDictionary {
        var dict: JSONDictionary = [:]
        
        dict[TOKEN_KEY] = accessToken
        dict[EMAIL_KEY] = email
        return dict
    }
}
