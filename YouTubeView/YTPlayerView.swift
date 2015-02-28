                                                                                                                                         //
//  YTPlayerView.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import UIKit

protocol YTPlayerDelegate {
//    func playerHadIframeApiReady(playerView: YTPlayerView)
    func playerDidBecomeReady(playerView: YTPlayerView)
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState)
    func playerDidChangeToQuality(playerView: YTPlayerView, quality: YTPlayerQuality)
}

class YTPlayerView: UIView, UIWebViewDelegate {
    
    let originalUrl = "about:blank"
    var videoId = ""
    var delegate: YTPlayerDelegate?
     var webView: UIWebView?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadPlayerWithOptions(nil)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadPlayerWithOptions(nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func loadVideoById(id: String) {
        var js = "player.loadVideoById('\(id)', 0, 'medium');"
        self.evaluateJavaScript(js)
    }
    
    func loadPlayerWithOptions(option: Dictionary<String, String>?) -> Bool {
        let bundle = NSBundle.mainBundle();
        let path = NSBundle.mainBundle().pathForResource("YTPlayerIframeTemplate", ofType: "html")
        if path == nil {
            return false
        }
        var err: NSError?
        let template = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: &err) as! String
        if err != nil {
            return false
        }
        newWebView()
        self.webView?.loadHTMLString(template, baseURL: NSURL(string: originalUrl))
        self.webView?.delegate = self
        self.webView?.allowsInlineMediaPlayback = true
        self.webView?.mediaPlaybackRequiresUserAction = false
        return true
    }
    
    func playVideo() {
        evaluateJavaScript("player.playVideo();")
    }
    
    func getAvailableQualityLevelsString() -> String? {
        return evaluateJavaScript("player.getAvailableQualityLevels().toString();")
    }
    func getAvailableQualityLevels() -> [YTPlayerQuality] {
        let raw = getAvailableQualityLevelsString()
        var levels = [YTPlayerQuality]()
        if raw == nil {
            return levels
        }
        let rawArray = raw!.componentsSeparatedByString(",")
        for rawLevel in rawArray {
            if let level = YTPlayerQuality(rawValue: rawLevel) {
                levels.append(level)
            }
        }
        return levels
    }
    
    private func evaluateJavaScript(js: String) -> String? {
        return self.webView?.stringByEvaluatingJavaScriptFromString(js)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
//        println(error)
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url: NSURL
        
//        println(request.URL?.absoluteString)
        
        if request.URL == nil {
            return false
        }
        url = request.URL!
        if url.host == originalUrl {
            return true
        }
        else if url.scheme == "http" || url.scheme == "https" {
            return shouldNavigateToUrl(url)
        }
        
        if url.scheme == "ytplayer" {
            delegateEvents(url)
            return false
        }
        return true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
//        println(webView.request)
    }
    
    private func shouldNavigateToUrl(url: NSURL) -> Bool {
        return true
    }
    /**
    * Private method to handle "navigation" to a callback URL of the format
    * ytplayer://action?data=someData
    */
    private func delegateEvents(event: NSURL) {
        let action: String = event.host!
        let callback: YTPlayerCallback? = YTPlayerCallback(rawValue: action)
        let query = event.query
        let data = query?.substringFromIndex(advance(query!.startIndex, 5))
        if callback == nil {
            return
        }
        switch callback! {
        case .OnYouTubeIframeAPIReady:
            println("api ready")
//            delegate?.playerHadIframeApiReady(self)
        case .OnReady:
            delegate?.playerDidBecomeReady(self)
        case .OnStateChange:
            if let state = YTPlayerState(rawValue: data!) {
                delegate?.playerDidChangeToState(self, state: state)
            }
        case .OnPlaybackQualityChange:
            if let quality = YTPlayerQuality(rawValue: data!) {
                delegate?.playerDidChangeToQuality(self, quality: quality)
            }
        default:
            println("error: \(data)")
        }
    }
    
    // add and remove webview
    private func newWebView() {
        removeWebView()
        let newWebView = UIWebView(frame: self.bounds)
        newWebView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        newWebView.scrollView.scrollEnabled = false
        newWebView.scrollView.bounces = false
        newWebView.allowsInlineMediaPlayback = true
        newWebView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.webView = newWebView
        self.addSubview(self.webView!)
    }
    private func removeWebView() {
        self.webView?.removeFromSuperview()
        self.webView = nil
    }
    
    
}
