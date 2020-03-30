//
//  NumbersModel.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 28/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import Foundation

// MARK: - NumbersModel
class NumbersModel: NSObject, Codable, NSCoding {
    var majorPhones : [Phone] = []
    var publicPhones : [Phone] = []
    var globalPhones : [Phone] = []
//    var majorPhones, publicPhones, globalPhones: [Phone]

    init(majorPhones: [Phone], publicPhones: [Phone], globalPhones: [Phone]) {
        self.majorPhones = majorPhones
        self.publicPhones = publicPhones
        self.globalPhones = globalPhones
    }
    
    required init(coder aDecoder: NSCoder) {
        majorPhones  = aDecoder.decodeObject(forKey: "majorPhones") as! [Phone]
        publicPhones = aDecoder.decodeObject(forKey: "publicPhones") as! [Phone]
        globalPhones = aDecoder.decodeObject(forKey: "globalPhones") as! [Phone]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(majorPhones, forKey: "majorPhones")
        aCoder.encode(publicPhones, forKey: "publicPhones")
        aCoder.encode(globalPhones, forKey: "globalPhones")
    }
    
}

// MARK: - Category
class Category: NSObject, Codable, NSCoding {
    var id: Int = 0
    var name: String = ""

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        id   = aDecoder.decodeInteger(forKey: "id")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
    }
}

// MARK: - Phone
class Phone: NSObject, Codable, NSCoding {
    var id: Int = 0
    var name: String = ""
    var category: Category?
    var neighborhood: CityModel?
    var province: CityModel?
    var district: CityModel?
    var phone: String = ""

    init(id: Int, name: String, category: Category, neighborhood: CityModel?, province: CityModel, district: CityModel?, phone: String) {
        self.id = id
        self.name = name
        self.category = category
        self.neighborhood = neighborhood
        self.province = province
        self.district = district
        self.phone = phone
    }
    
    required init(coder aDecoder: NSCoder) {
        name         = aDecoder.decodeObject(forKey: "name") as! String
        id           = aDecoder.decodeInteger(forKey: "id")
        category     = aDecoder.decodeObject(forKey: "category") as? Category
        neighborhood = aDecoder.decodeObject(forKey: "neighborhood") as? CityModel
        province     = aDecoder.decodeObject(forKey: "province") as? CityModel
        district     = aDecoder.decodeObject(forKey: "district") as? CityModel
        phone        = aDecoder.decodeObject(forKey: "phone") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(neighborhood, forKey: "neighborhood")
        aCoder.encode(province, forKey: "province")
        aCoder.encode(district, forKey: "district")
        aCoder.encode(phone, forKey: "phone")
    }
}
