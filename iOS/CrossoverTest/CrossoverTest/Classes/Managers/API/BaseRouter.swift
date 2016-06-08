//
//  BaseRouter.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String : AnyObject]?

protocol APIConfiguration {
    var method: Alamofire.Method { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String? { get }
}

class BaseRouter : URLRequestConvertible, APIConfiguration {
    
    init() {}
    
    var method: Alamofire.Method {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var baseUrl: String? {
//        guard let url = NSBundle.mainBundle().objectForInfoDictionaryKey("API_BASE_URL") as? String else {return nil}
//        return url
        
        //Local Mock Server (GCDWebServer) 
        return MockServer.sharedInstance.baseUrl
    }
    
    var URLRequest: NSMutableURLRequest {
        let baseURL = NSURL(string: baseUrl!)
        let mutableURLRequest = NSMutableURLRequest(URL: baseURL!.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        if let encoding = encoding {
            return encoding.encode(mutableURLRequest, parameters: parameters).0
        }
        return mutableURLRequest
    }
}
