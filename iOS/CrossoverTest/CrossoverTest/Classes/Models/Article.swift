//
//  Article.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

private let ID_KEY = "articleID"
private let TITLE_KEY = "title"
private let BODY_KEY = "body"

class Article: Object {
    
    dynamic var articleID: Int = 0
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "articleID"
    }
    
    required init() {
        super.init()   
    }
    
    convenience init(json: JSONDictionary) {
        self.init()
        populateWithJSON(json)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init()
//        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
//        fatalError("init(realm:schema:) has not been implemented")
    }
    
    func populateWithJSON(dictionary: JSONDictionary) {
        if let id = dictionary[ID_KEY] as? Int {
            self.articleID = id
        }
        if let title = dictionary[TITLE_KEY] as? String {
            self.title = title
        }
        if let body = dictionary[BODY_KEY] as? String {
            self.body = body
        }
    }
    
    func toJsonDictionary() -> JSONDictionary {
        var dict: JSONDictionary = [:]
        
        dict[ID_KEY] = articleID
        dict[TITLE_KEY] = title
        dict[BODY_KEY] = body
        
        return dict
    }
}