//
//  QualityOfServiceModel.swift
//  YouSlow
//
//  Created by to0 on 3/8/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import Foundation

class QualityOfService {
    private var lastBuffering = 0.0
    var numOfBufferings = 0
    var durationOfBufferings = 0.0
    // key is timestamp, value is duration
    private var bufferings = Dictionary<Double, Double>()
    // key is timestamp, value is resolution quality
    private var resolutions = Dictionary<Double, String>()
    var length: Double?
    // in milliseconds
    var initialBuffering = 0
    var abandonment = ""
    var availableQualities = ""
    
    var bufferingsWithTime: String {
        var description = ""
        for (key, value) in bufferings {
            description += "\(key)?\(value):"
        }
        return description
    }
    var timesOfResolutionChange: Int {
        return resolutions.count
    }
    var requestedResolutions: String {
        var res = ""
        for (key, value) in resolutions {
            res += "\(value):"
        }
        return res
    }
    var requestedResolutionsWithTime: String {
        var res = ""
        for (key, value) in resolutions {
            res += "\(key)?\(value):"
        }
        return res
    }
    func getVideoLength(l: Double) {
        length = l
    }
    
    func startBuffering(startTime: Double) {
        lastBuffering = startTime
    }
    func endBuffering(endTime: Double) {
        bufferings[lastBuffering] = endTime - lastBuffering
    }
}