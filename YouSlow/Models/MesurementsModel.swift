//
//  MesurementsModel.swift
//  YouSlow
//
//  Created by to0 on 2/28/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

//import Foundation
import CoreLocation

class Mesurements {
    private var location: Location?
    private let qos = QualityOfService()
    private var token = dispatch_once_t()
    
    func getLocation(CLLocation) {
        dispatch_once(&token, {
            
        })
    }
}

class Location {
    var coordinates: String
    var country: String
    var city: String
    
    init(coordinates coord: String, country : String, city : String) {
        coordinates = coord
        self.country = country
        self.city = city
    }
}

class QualityOfService {
    var q = ""
}