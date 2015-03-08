//
//  MesurementsModel.swift
//  YouSlow
//
//  Created by to0 on 2/28/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

//import Foundation
import UIKit
import CoreLocation

class Measurements{
    private var location = Location()
    private let org = Org()
    private let qos = QualityOfService()
    private var token = dispatch_once_t()
    
//    func initLocation() {
//        dispatch_once(&token, {
//            self.org.getISP()
//        })
//    }
}

class Org {
    private var org: String?
    private var token = dispatch_once_t()
    
    init() {
        getISP()
    }
    
    var isReady: Bool {
        return org != nil
    }
    private func getISP() {
        if isReady {
            return
        }
        DataApi.sharedInstance.getNetworkInfo(convertResponse, fail: failHandler)
    }
    private func convertResponse(res: NSDictionary) {
        if let org = res["org"] as? String {
            self.org = org.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
            println("ISP: \(self.org!)")
        }
    }
    private func failHandler(err: NSError) {
        
    }
//    func updateISPThen(success: () -> Void) {
//        
//    }
}

class Location: NSObject, CLLocationManagerDelegate {
    private var coordinates: String?
    private var country: String?
    private var city: String?
    private var region: String?
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var currentLocation: CLLocation?
    var geoCoderToken = dispatch_once_t()
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
            if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0 {
                locationManager.requestWhenInUseAuthorization()
            }
        }
        locationManager.startUpdatingLocation()
    }
    
    private func decodeLocation(array: [AnyObject]!, err: NSError!) -> Void {
        if err == nil {
            let mark = array.first as! CLPlacemark
            country = mark.ISOcountryCode
            city = mark.subAdministrativeArea.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
            region = mark.administrativeArea
            coordinates = "\(mark.location.coordinate.latitude),\(mark.location.coordinate.longitude)"
            println("Country: \(country!)")
            println("City: \(city!)")
            println("Region: \(region!)")
            println("Loc: \(coordinates!)")
        }
    }
    // Delegates
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //An array of CLLocation objects. The most recent location update is at the end of the array.
        currentLocation = locations.last as? CLLocation
        dispatch_once(&geoCoderToken, {
//            println(self.currentLocation)
            self.geoCoder.reverseGeocodeLocation(self.currentLocation!, completionHandler: self.decodeLocation)
        })
    }
}

class QualityOfService {
    var q = ""
}