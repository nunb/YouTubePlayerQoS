//
//  SingleVideoViewController.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//
import Foundation
import UIKit

class SingleVideoViewController: UIViewController, YTPlayerDelegate {

    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var qualityLabel: UILabel!
    @IBOutlet var availableQualitiesLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var ispLabel: UILabel!
    var measurements = Measurements()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
//        measurements.initLocation()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        self.playerView.removeWebView()
    }
    
    // Delegates
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

