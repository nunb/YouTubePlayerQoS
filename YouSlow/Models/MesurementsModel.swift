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
    private let qos = QualityOfService()
    private var token = dispatch_once_t()
    private var startTime: NSDate?
    private var lastState = YTPlayerState.Unstarted
    private var reportToken = dispatch_once_t()
    private var startToken = dispatch_once_t()
    func startMeasuring() {
        startTime = NSDate()
    }
    func endMeasuring(fraction: String) {
        qos.loadedFraction = fraction
    }
    func reportMeasurements() {
        dispatch_once(&reportToken, {
            [weak self] in
            if self == nil {
                return
            }
            if self!.lastState == YTPlayerState.Ended {
                self!.qos.abandonment = "0"
            }
            else if self?.lastState == YTPlayerState.Buffering {
                self!.qos.abandonment = "1"
            }
            else {
                self!.qos.abandonment = "2"
            }
            var report = [String: String]()

            report["city"] = self!.location.city!
            report["region"] = self!.location.region!
            report["country"] = self!.location.country!
            report["loc"] = self!.location.coordinates!
            report["org"] = self!.location.org
            report["numofrebufferings"] = "\(self!.qos.numOfBufferings)"
            report["bufferduration"] = "\(self!.qos.durationOfBufferings)"
            report["bufferdurationwithtime"] = self!.qos.bufferingsWithTime
            report["resolutionchanges"] = "\(self!.qos.resolutionChanges)"
            report["requestedresolutions"] = self!.qos.requestedResolutions
            report["requestedresolutionswithtime"] = self!.qos.requestedResolutionsWithTime
            report["timelength"] = "\(self!.qos.timeLength)"
            report["abandonment"] = "\(self!.qos.abandonment):\(self!.qos.loadedFraction)"
            report["allquality"] = self!.qos.availableQualities
            
            DataApi.sharedInstance.postYouSlow(report, success: {
                (res: NSDictionary) in
            })
        })
    }
    // Delegates
    func playerHadIframeApiReady(playerView: YTPlayerView) {
//        println("api ready")
    }
    func playerDidBecomeReady(playerView: YTPlayerView) {
        
        qos.timeLength = playerView.getVideoDuration()!
    }
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState) {
        if state != YTPlayerState.Unstarted {
            dispatch_once(&startToken, {
                [weak self] in
                self?.startMeasuring()
            })
        }
        if state == YTPlayerState.Buffering {
            if startTime == nil {
                return
            }
            if lastState == YTPlayerState.Playing {
                let time = 0 - Int(startTime!.timeIntervalSinceNow)
                qos.startBuffering(time)
            }
        }
        else if state == YTPlayerState.Playing {
            if startTime == nil {
                return
            }
            if lastState == YTPlayerState.Buffering {
                let time = 0 - Int(startTime!.timeIntervalSinceNow)
                qos.endBuffering(time)
            }
        }
        lastState = state
        qos.availableQualities = playerView.getAvailableQualityLevelsString()!
        if state == YTPlayerState.Ended {
            reportMeasurements()
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

