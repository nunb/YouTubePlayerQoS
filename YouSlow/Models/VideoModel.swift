//
//  VideoModel.swift
//  Demo
//
//  Created by to0 on 2/7/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import Foundation

protocol VideoListProtocol {
    func didReloadVideoData()
}

private class VideoItem  {
    var thumbnail = ""
    var videoId = ""
    var title = ""
    init(thumbnail th: String, videoId id: String, title ti: String) {
        thumbnail = th
        videoId = id
        title = ti
    }
}

class VideoList {
    private var videos = [VideoItem]()
    var delegate: VideoListProtocol?
    
    init() {
        
    }
    
    func isValidIndex(index: Int) -> Bool {
        return index >= 0 && index < videos.count
    }
    func numberOfVideos() -> Int {
        return videos.count
    }
    
    func videoTitleOfIndex(index: Int) -> String {
        if !isValidIndex(index) {
            return ""
        }
        let v = videos[index]
        return v.title
    }
    
    func videoIdOfIndex(index: Int) -> String {
        if !isValidIndex(index) {
            return ""
        }
        let v = videos[index]
        return v.videoId
    }
    
    func reloadVideosFromJson(jsonObject: NSDictionary) {
        videos = []
        if let rawItems = jsonObject["items"] as? [NSDictionary] {
            for rawItem: NSDictionary in rawItems {
                let th = (((rawItem["snippet"] as? NSDictionary)?["thumbnails"] as? NSDictionary)?["default"] as? NSDictionary)?["url"] as? String
                let id = (rawItem["id"] as? NSDictionary)?["videoId"] as? String
                let ti = (rawItem["snippet"] as? NSDictionary)?["title"] as? String
                if th != nil && id != nil && ti != nil {
                    videos.append(VideoItem(thumbnail: th!, videoId: id!, title: ti!))
                }
            }
        }
    }
    
    func requestDataForRefresh() {
        let api =  YouTubeDataApi.sharedInstance
        api.getList({(data: NSDictionary) -> Void in
            self.reloadVideosFromJson(data)
            self.delegate?.didReloadVideoData()
        })
    }
}
