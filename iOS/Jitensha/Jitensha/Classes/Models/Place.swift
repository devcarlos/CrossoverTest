//
//  Place.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//


import Foundation
import RealmSwift
import Realm

private let ID_KEY = "id"
private let NAME_KEY = "name"
private let LOC_KEY = "location"
private let LAT_KEY = "lat"
private let LNG_KEY = "lng"

//Location Model Class
public class Place: Object {
    
    //MARK : Properties
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var lat: Double = 0.0
    dynamic var lng: Double = 0.0
    
    override public static func primaryKey() -> String? {
        return ID_KEY
    }
    
    //MARK : init functions
    
    required public init() {
        super.init()
    }
    
    convenience init(json: JSONDictionary) {
        self.init()
        populateWithJSON(json)
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    
    //MARK : JSON Parse Functions
    
    func populateWithJSON(dictionary: JSONDictionary) {
        if let id = dictionary[ID_KEY] as? String {
            self.id = id
        }
        if let name = dictionary[NAME_KEY] as? String {
            self.name = name
        }
        
        if let location = dictionary[LOC_KEY] as? JSONDictionary {
            if let lat = location[LAT_KEY] as? Double {
                self.lat = lat
            }
            if let lng = location[LNG_KEY] as? Double {
                self.lng = lng
            }
        }
    }
    
    func toJsonDictionary() -> JSONDictionary {
        var dict: JSONDictionary = [:]
        
        dict[ID_KEY] = id
        dict[NAME_KEY] = name
        dict[LAT_KEY] = lat
        dict[LNG_KEY] = lng
        
        return dict
    }
}
