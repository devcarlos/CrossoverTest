//
//  MockServer.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import GCDWebServer
import SwiftyJSON

private let ArticleMockDataFilename = "articles"

class MockServer {
    
    let webServer = GCDWebServer()
    
    class var sharedInstance: MockServer {
        struct Singleton {
            static let instance : MockServer = MockServer()
        }
        return Singleton.instance
    }
    
    init() {
        webServer.addHandlerForMethod("GET", pathRegex: "/articles", requestClass: GCDWebServerRequest.self, processBlock: { request in
            let dict = self.jsonDictionaryFromFile("articles")
            return GCDWebServerDataResponse(JSONObject: dict)
        })
        
        webServer.startWithPort(8080, bonjourName: "Alamofire Example GCD Web Server")
    }
    
    var articles: JSONDictionary {
        return jsonDictionaryFromFile(ArticleMockDataFilename)
    }
    
    
    func jsonDictionaryFromFile(filename: String) -> JSONDictionary {
        let jsonString = NSBundle.stringFromFile(filename)!
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let json = JSON(data: jsonData)
        return json.dictionaryObject!
    }
    
    var baseUrl: String {
        return "\(webServer.serverURL)"
    }
}
