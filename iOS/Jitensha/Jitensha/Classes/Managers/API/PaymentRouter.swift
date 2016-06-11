//
//  PaymentRouter.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

enum PaymentEndpoint {
    case Payment(number: String, name: String, exp: String, code: String)
}

class PaymentRouter : BaseRouter {
    
    var endpoint: PaymentEndpoint
    
    override var isAuthorized: Bool? {
        return true
    }
    
    init(endpoint: PaymentEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: Alamofire.Method {
        switch endpoint {
        case .Payment: return .POST
        }
    }
    
    override var path: String {
        switch endpoint {
        case .Payment: return "rent"
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .Payment(let number, let name, let exp, let code):
            return ["number": number, "name": name, "expiration": exp, "code": code]
        }
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        switch endpoint {
        case .Payment: return .URL
        }
    }
    
}
