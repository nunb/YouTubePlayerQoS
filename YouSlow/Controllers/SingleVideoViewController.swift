//
//  FirstViewController.swift
//  Demo
//
//  Created by to0 on 2/1/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import UIKit

class SingleVideoViewController: UIViewController, YTPlayerDelegate {

    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var qualityLabel: UILabel!
    @IBOutlet var availableQualitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
//        playerView.loadPlayerWithOptions(nil)
//        playerView.loadVideoById("M7lc1UVf-VE")
//        playerView.playVideo()
    }
    override func viewWillAppear(animated: Bool) {
        
    }
    override func viewDidAppear(animated: Bool) {
        println(playerView.frame)
        println(playerView.webView?.frame)
        println(playerView.webView?.scrollView.contentOffset)
        println(playerView.webView?.scrollView.contentSize)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegates
    func playerHadIframeApiReady(playerView: YTPlayerView) {
        println("api ready")
    }
    func playerDidBecomeReady(playerView: YTPlayerView) {
//        availableQualitiesLabel.text = playerView.getAvailableQualityLevelsString()
    }
    func playerDidChangeToState(playerView: YTPlayerView, state: YTPlayerState) {
        availableQualitiesLabel.text = playerView.getAvailableQualityLevelsString()
        
    }
    func playerDidChangeToQuality(playerView: YTPlayerView, quality: YTPlayerQuality) {
        println(quality.rawValue)
        qualityLabel.text = quality.rawValue
    }

}

