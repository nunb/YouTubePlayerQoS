//
//  IspModel.swift
//  YouSlow
//
//  Created by to0 on 3/8/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import Foundation

class Isp {
    private var org: String?
    private var token = dispatch_once_t()
    
    init() {
        getOrg()
    }
    
    var isReady: Bool {
        return org != nil
    }
    private func getOrg() {
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
}