//
//  APIConstants.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

let baseURL = ""
let getCitiesUrl = "https://rocky-reef-05857.herokuapp.com/api/v0/provinces"
let getDistrictsUrl = "https://rocky-reef-05857.herokuapp.com/api/v0/districts/"
let getNumbersUrl = "https://rocky-reef-05857.herokuapp.com/api/v0/phones/id?district_id="
let getGeneralNumbersUrl = "https://rocky-reef-05857.herokuapp.com/api/v0/phones/id?province_id="

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum ResponseError : String {
    case serverNoData = "server_no_data"
    case serverError = "server_error"
    case decodingError = "decoding_error"
}

enum HTTPHeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case userToken = "userToken"
    case appCode = "appCode"
    case appType = "appType"
}

enum RequestContentType: String {
    case json = "application/json"
}
