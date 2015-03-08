//
//  MesurementsModel.swift
//  YouSlow
//
//  Created by to0 on 2/28/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

//import Foundation
import CoreLocation

class Measurements {
    private var location = Location()
    private let qos = QualityOfService()
    private var token = dispatch_once_t()
    
    func initLocation() {
        dispatch_once(&token, {
            self.location.getLocation()
        })
    }
}

class Location {
    private var coordinates: String?
    private var country: String?
    private var city: String?
    private var region: String?
    private var org: String?
    var isReady: Bool {
        return coordinates != nil && country != nil && city != nil
    }
    func getLocation() {
        if isReady {
            return
        }
        DataApi.sharedInstance.getNetworkInfo(convertResponse, fail: failHandler)
    }
    private func convertResponse(res: NSDictionary) {
        if let city = res["city"] as? String, region = res["regionName"] as? String, country = res["countryCode"] as? String, lat = res["lat"] as? Float, lon = res["lon"] as? Float, org = res["org"] as? String {
            self.city = city.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
            self.country = country
            self.region = region.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
            self.coordinates = "\(lat),\(lon)"
            self.org = org.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
        }
    }
    private func failHandler(err: NSError) {
        
    }
    func updateLocationThen(success: () -> Void) {
        
    }
}

class QualityOfService {
    var q = ""
}