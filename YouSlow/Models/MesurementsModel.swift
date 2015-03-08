//
//  MesurementsModel.swift
//  YouSlow
//
//  Created by to0 on 2/28/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import Foundation

class Measurements: YTPlayerDelegate{
    private var location = Location()
    private let isp = Isp()
    private let qos = QualityOfService()
    private var token = dispatch_once_t()
    func startMeasuring() {
        
    }
    func endMeasuring() {
        
    }
    func reportMeasurements() {
        
    }
    // Delegates
    func playerHadIframeApiReady(playerView: YTPlayerView) {
//        println("api ready")
    }
    func playerDidBecomeReady(playerView: YTPlayerView) {
//        availableQualitiesLabel.text = "Available: " + playerView.getAvailableQualityLevelsString()!
    }
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState) {
        if state == YTPlayerState.Buffering {
            qos.startBuffering(0)
        }
        
//        stateLabel.text = "State: \(state.rawValue)"
//        availableQualitiesLabel.text = "Available: \(playerView.getAvailableQualityLevelsString()!)"
    }
    func playerDidChangeToQuality(playerView: YTPlayerView, quality: YTPlayerQuality) {
//        qualityLabel.text = "Quality: \(quality.rawValue)"
    }
}

