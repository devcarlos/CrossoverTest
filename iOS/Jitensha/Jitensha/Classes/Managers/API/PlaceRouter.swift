//
//  PlaceRouter.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

enum PlaceEndpoint {
    case GetPlaces()
}

class PlaceRouter : BaseRouter {
    
    var endpoint: PlaceEndpoint
    
    override var isAuthorized: Bool? {
        return true
    }
    
    init(endpoint: PlaceEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: Alamofire.Method {
        switch endpoint {
        case .GetPlaces: return .GET
        }
    }
    
    override var path: String {
        switch endpoint {
        case .GetPlaces: return "places"
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .GetPlaces():
            return [:]
        }
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        switch endpoint {
        case .GetPlaces: return .URL
        }
    }
    
}
