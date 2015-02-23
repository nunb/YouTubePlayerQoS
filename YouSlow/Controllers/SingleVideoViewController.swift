//
//  FirstViewController.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

class SingleVideoViewController: UIViewController, YTPlayerDelegate, CLLocationManagerDelegate {

    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var qualityLabel: UILabel!
    @IBOutlet var availableQualitiesLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    var locationManager: CLLocationManager = CLLocationManager()
    
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
        // Do any additional setup after loading the view, typically from a nib.

    }
    override func viewWillAppear(animated: Bool) {
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegates
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.Authorized || status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationLabel.text = "Location: \(locations)"
//        println(locations)
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    func playerHadIframeApiReady(playerView: YTPlayerView) {
        println("api ready")
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

