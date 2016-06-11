//
//  SessionRouter.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

//Session Endpoint Enum
enum SessionEndpoint {
    case GetToken(email: String, password: String)
    case Register(email: String, password: String)
}

//Session Router Class based on BaseRouter
class SessionRouter : BaseRouter {
    
    var endpoint: SessionEndpoint
    init(endpoint: SessionEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: Alamofire.Method {
        switch endpoint {
            case .GetToken: return .POST
            case .Register: return .POST
        }
    }
    
    override var path: String {
        switch endpoint {
            case .GetToken: return "auth"
            case .Register: return "register"   
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .GetToken(let email, let password):
            return ["email" : email, "password" : password]
        case .Register(let email, let password):
            return ["email" : email, "password" : password]
            
        }//default is not necessary
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        switch endpoint {
            case .GetToken: return .URL
            case .Register: return .URL
        }//default is not necessary
    }
}
