//
//  APIRequest.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

public typealias HTTPBodyParameters = [String : Any]?
public typealias HTTPHeaders = [String : String]?
public typealias HTTPUrlParameters = [String : Any]?

class APIRequest: NSObject {
    var endPoint: String!
    var httpMethod: HTTPMethod!
    var headers = HTTPHeaders([:])
    var bodyParameters: HTTPBodyParameters?
    var urlParameters: HTTPUrlParameters?
    
    func initAPIRequest(endPoint: String, httpMethod: HTTPMethod, headers: HTTPHeaders?, bodyParameters: HTTPBodyParameters?, urlParameters: HTTPUrlParameters?) {
        self.endPoint = baseURL + endPoint
        self.httpMethod = httpMethod
        self.headers = setHeaders()
        self.bodyParameters = bodyParameters
        self.urlParameters = urlParameters        
        setUrlParameters()
    }
    
    func APIRequest(succeed: @escaping (_ responseData : Data, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {}
    
    private func setUrlParameters() {
        guard urlParameters != nil else {
            return
        }
        
        var index = 0
        
        for (key, value) in urlParameters!! {
            endPoint.append(key)
            endPoint.append("=")
            endPoint.append(String(describing: value))
            
            if index < urlParameters!!.count - 1 {
                index = index + 1
                endPoint.append("&")
            }
        }
    }
    
    private func setHeaders() -> HTTPHeaders {
        var headerSet = HTTPHeaders([:])
        headerSet?.updateValue(RequestContentType.json.rawValue, forKey: HTTPHeaderField.contentType.rawValue)
        headerSet?.updateValue(RequestContentType.json.rawValue, forKey: HTTPHeaderField.accept.rawValue)
        return headerSet
    }
}
