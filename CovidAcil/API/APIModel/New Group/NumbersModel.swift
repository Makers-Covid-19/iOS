//
//  NumbersModel.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 28/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

// MARK: - NumbersModel
class NumbersModel: Codable {
    let majorPhones, publicPhones, globalPhones: [Phone]

    init(majorPhones: [Phone], publicPhones: [Phone], globalPhones: [Phone]) {
        self.majorPhones = majorPhones
        self.publicPhones = publicPhones
        self.globalPhones = globalPhones
    }
}

// MARK: - Category
class Category: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Phone
class Phone: Codable {
    let id: Int
    let name: String
    let category: Category
    let neighborhood: CityModel?
    let province: CityModel
    let district: CityModel?
    let phone: String

    init(id: Int, name: String, category: Category, neighborhood: CityModel?, province: CityModel, district: CityModel?, phone: String) {
        self.id = id
        self.name = name
        self.category = category
        self.neighborhood = neighborhood
        self.province = province
        self.district = district
        self.phone = phone
    }
}
