//
//  SingleVideoViewController.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//
import Foundation
import UIKit

class SingleVideoViewController: UIViewController, MeasurementsDelegate{

    @IBOutlet var videoQualityLabel: UILabel!
    @IBOutlet var videoStateLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
//    var playerView: YTPlayerView
    var measurements = Measurements()
    var videoId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let width = self.view.frame.width;
//        let height = width * 3 / 4;
        playerView.loadPlayerWithOptions(videoId)
        playerView.delegate = measurements
        measurements.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        if let fraction = playerView.getVideoLoadedFraction() {
//            measurements.endMeasuring(fraction)
//            measurements.reportMeasurements()
        }
        
        playerView.removeWebView()

    }
    func didChangeToQuality(quality: String) {
        videoQualityLabel.text = "Video Quality: \(quality)"
    }
    func didChangeToState(state: String) {
        videoStateLabel.text = "Video State: \(state)"
    }
}

