//
//  CityModel.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let id: Int
    let name: String
    
    enum codingKeys: String, CodingKey {
        case id, name
    }
}
