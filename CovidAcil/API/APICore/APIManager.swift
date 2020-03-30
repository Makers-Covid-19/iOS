//
//  APIManager.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager: NSObject {
    
    static func request(_APIRequest: APIRequest, succeed: @escaping (_ resultJSON : Any, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {
            
        let headers : HTTPHeaders = HTTPHeaders.init(_APIRequest.headers!)
        
        print("***********************************")
        print("Headers: ", headers)
        print("End point: ", _APIRequest.endPoint!)
        print("URL Parameters: ", _APIRequest.urlParameters as Any? ?? "nil")
        print("Body Parameters: ", _APIRequest.bodyParameters as Any? ?? "nil")
        print("***********************************")
        
        if (_APIRequest.httpMethod! == HTTPMethod.get){
            AF.request(_APIRequest.endPoint, method: .get, parameters: _APIRequest.bodyParameters ?? nil, encoding: JSONEncoding(), headers: headers).responseJSON { response in
                guard let responseData = response.data else {
                    failed(getLocalizedStringForKey(ResponseError.serverNoData.rawValue))
                    return
                }
                do {
                    let decoded = try JSONSerialization.jsonObject(with: responseData, options: [])
                    if let responseJSON = decoded as? [String : Any] {
                        print("***********************************")
                        print("End point: ", _APIRequest.endPoint!)
                        print("Response: ", responseJSON)
                        print("***********************************")
                        
                        guard let httpStatus = responseJSON["httpStatus"] as? String else {
                            failed(getLocalizedStringForKey(ResponseError.serverError.rawValue))
                            return
                        }
                        
                        if httpStatus == "OK" {
                            succeed(responseJSON["data"] as Any, nil)
                        }
                        else {
                            if let message = responseJSON["message"] as? String {
                                failed(message)
                            }
                            else {
                                failed(getLocalizedStringForKey(ResponseError.serverError.rawValue))
                            }
                        }
                    }
                    else {
                        failed(getLocalizedStringForKey(ResponseError.decodingError.rawValue))
                    }
                }
                catch {
                    failed(error.localizedDescription)
                }
                LoadingView.stopLoading()
            }
        }
    }
}


