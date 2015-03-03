//
//  SingleVideoViewController.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import CoreTelephony
import SystemConfiguration

class SingleVideoViewController: UIViewController, YTPlayerDelegate, CLLocationManagerDelegate {

    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var qualityLabel: UILabel!
    @IBOutlet var availableQualitiesLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var ispLabel: UILabel!
    var locationManager: CLLocationManager = CLLocationManager()
    var telephonyInfo = CTTelephonyNetworkInfo()

    var city: String?
    var country: String?
    var loc: String?
    var isp: CTCarrier?
    
//    required init(coder aDecoder: NSCoder) {
//        super.init()
//        initLocationManager()
//    }
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init()
//        initLocationManager()
//    }
//    
//    override init() {
//        super.init()
//        initLocationManager()
//    }
    
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0 {
                locationManager.requestWhenInUseAuthorization()
            }
        }
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        playerView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
//        isp = telephonyInfo.currentRadioAccessTechnology
//        system
//        ispLabel.text = "ISP: \(telephonyInfo.currentRadioAccessTechnology)"
    }
    override func viewWillAppear(animated: Bool) {
        let api = YouTubeDataApi.sharedInstance
        api.getNetworkInfo({(res: NSDictionary) -> Void in
            let org = res["org"] as! String
            dispatch_async(dispatch_get_main_queue(), {
                self.ispLabel.text = "ISP: \(org)"
            })
        })

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        self.playerView = nil
    }
    
    // Delegates
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //An array of CLLocation objects. The most recent location update is at the end of the array.
        let currentLocation = locations.last as! CLLocation
        locationLabel.text = "Location: \(currentLocation)"
//        println(locations)
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        println(error)
    }
    func playerHadIframeApiReady(playerView: YTPlayerView) {
//        println("api ready")
    }
    func playerDidBecomeReady(playerView: YTPlayerView) {
        availableQualitiesLabel.text = "Available: " + playerView.getAvailableQualityLevelsString()!
    }
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState) {
        stateLabel.text = "State: \(state.rawValue)"
        availableQualitiesLabel.text = "Available: \(playerView.getAvailableQualityLevelsString()!)"
    }
    func playerDidChangeToQuality(playerView: YTPlayerView, quality: YTPlayerQuality) {
        qualityLabel.text = "Quality: \(quality.rawValue)"
    }

}

