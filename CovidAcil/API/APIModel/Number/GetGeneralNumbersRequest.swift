//
//  GetGeneralNumbersRequest.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 30/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

final class GetGeneralNumbersRequest: APIRequest {
    
    init(id : Int) {
        super.init()
        
        super.initAPIRequest(endPoint: getGeneralNumbersUrl + String(id),
                             httpMethod: HTTPMethod.get,
                             headers: nil,
                             bodyParameters: nil,
                             urlParameters: nil)
    }
    
    override func APIRequest(succeed: @escaping (_ responseData : Data, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {
        DispatchQueue.main.async {
            LoadingView.startLoading()
            
            APIManager.request(_APIRequest: self, succeed: { (_ resultJSON : Any, _ message : String?) in
                do {
                    let data = try JSONSerialization.data(withJSONObject: resultJSON, options: [])
                    succeed(data, message)
                }
                catch {
                    failed(error.localizedDescription)
                }
            }, failed: { (_ message : String) in
                failed(message)
            })
        }
    }
}
