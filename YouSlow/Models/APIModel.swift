//
//  APIResource.swift
//  Demo
//
//  Created by to0 on 2/4/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import UIKit

class YouTubeDataApi: NSObject, NSURLSessionDelegate {
    
    let session: NSURLSession?
    let host = "https://www.googleapis.com/youtube/v3/"
    let apiKey = "AIzaSyCQmq0XDn_UyKQtMcrKHlbVBKnWUsojqLg"
    let googleApiReferer = "app.demo.com"
    
    private override init() {
        super.init()
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["referer": googleApiReferer]
        session = NSURLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
    }
    
    class var sharedInstance : YouTubeDataApi {
        struct Static {
            static let instance = YouTubeDataApi()
        }
        return Static.instance
    }
    
    func getList(success: NSDictionary -> Void) {
        get("\(host)search?part=snippet", success: success)
    }
    
    private func get(path: String, success: (NSDictionary) -> Void, fail: ((NSError) -> Void)? = nil) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = NSURL(string: "\(path)&key=\(apiKey)")
        let task = session?.dataTaskWithURL(url!, completionHandler: {(data: NSData!, res: NSURLResponse!, err: NSError!) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if err != nil {
                if fail != nil {
                    println(err)
                    fail!(err)
                }
                return
            }
            var jsonErr: NSError?
            let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonErr)
            if jsonErr == nil {
                if let json = jsonObject as? NSDictionary  {
                    success(json)
                    return
                }
            }
            // Json Conversion Error
            fail?(NSError(domain: "json conversion", code: 510, userInfo: nil))
        })
        
        task?.resume()
    }
}
