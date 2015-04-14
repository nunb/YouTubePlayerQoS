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
    private var startTime: NSDate?
    private var lastState = YTPlayerState.Unstarted
    func startMeasuring() {
        startTime = NSDate()
    }
    func endMeasuring() {
        
    }
    func reportMeasurements() {
        var data = Dictionary<String, String>()
        DataApi.sharedInstance.postYouSlow(data, success: {
            (res: NSDictionary) in
            
            })
    }
    // Delegates
    func playerHadIframeApiReady(playerView: YTPlayerView) {
//        println("api ready")
    }
    func playerDidBecomeReady(playerView: YTPlayerView) {
    }
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState) {
        if state == YTPlayerState.Buffering {
            if startTime == nil {
                return
            }
            if lastState == YTPlayerState.Playing {
                let time = 0 - Int(startTime!.timeIntervalSinceNow)
                qos.startBuffering(time)
            }
            lastState = YTPlayerState.Buffering
        }
        else if state == YTPlayerState.Playing {
            if startTime == nil {
                return
            }
            if lastState == YTPlayerState.Buffering {
                let time = 0 - Int(startTime!.timeIntervalSinceNow)
                qos.endBuffering(time)
            }
            lastState = YTPlayerState.Playing
        }
        else if state == YTPlayerState.Cued {
            
        }
    }
    func playerDidChangeToQuality(playerView: YTPlayerView, quality: YTPlayerQuality) {
        if startTime == nil {
            return
        }
        let time = 0 - Int(startTime!.timeIntervalSinceNow)
        qos.changeToQuality(time, quality: quality.rawValue)
    }
}

