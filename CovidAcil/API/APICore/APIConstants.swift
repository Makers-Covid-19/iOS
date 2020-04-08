//
//  APIConstants.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

let baseURL = "https://api.covidacil.com/api/v0/"
let getCitiesUrl = "provinces"
let getDistrictsUrl = "districts/"
let getNumbersUrl = "phones/id?district_id="
let getGeneralNumbersUrl = "phones/id?province_id="

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
