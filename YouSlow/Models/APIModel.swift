//
//  APIResource.swift
//  Demo
//
//  Created by to0 on 2/4/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import UIKit

class DataApi {
    
    var session: NSURLSession = NSURLSession()
    let host = "https://www.googleapis.com/youtube/v3/"
    let apiKey = "AIzaSyCQmq0XDn_UyKQtMcrKHlbVBKnWUsojqLg"
    let googleApiReferer = "app.demo.com"
    
    static let sharedInstance = DataApi()
    
    private init() {
//        super.init()
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["referer": googleApiReferer]
        session = NSURLSession(configuration: sessionConfiguration)
    }
    
    func getList(success: NSDictionary -> Void) {
        get("\(host)search?part=snippet&key=\(apiKey)", success: success)
    }
    
    func getNetworkInfo(success: NSDictionary -> Void, fail: NSError -> Void) {
        get("http://ip-api.com/json/", success: success, fail: fail)
    }
    
    func postYouSlow(data: [String: String], success: NSDictionary -> Void) {
        var req = "version=iOS1.0&hostname=none&"
        let time = NSDate()
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        format.stringFromDate(time)
        req += "localtime=\(format.stringFromDate(time))&"
        
        for (key, value) in data {
            req += "\(key)=\(value)&"
        }
        
        get("https://dyswis.cs.columbia.edu/youslow/dbupdatesecured9.php?\(req)", success: success)
    }
    
    private func get(path: String, success: (NSDictionary) -> Void, fail: ((NSError) -> Void)? = nil) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = NSURL(string: path)

        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, res: NSURLResponse!, err: NSError!) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if err != nil {
                fail?(err)
                return
            }
            var jsonErr: NSError?
            let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonErr)
            if jsonErr != nil {
                // Json Conversion Error
//                let resString = String(data
                println(NSString(data: data, encoding:NSUTF8StringEncoding))
                fail?(NSError(domain: "json conversion", code: 510, userInfo: nil))
                return
            }
        
            if let json = jsonObject as? NSDictionary  {
                success(json)
                return
            }
        })
        
        task.resume()
    }
}
