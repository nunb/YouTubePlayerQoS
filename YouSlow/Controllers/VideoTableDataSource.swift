//
//  VideoTableDataSource.swift
//  Demo
//
//  Created by to0 on 2/12/15.
//  Copyright (c) 2015 to0. All rights reserved.
//

import UIKit

class VideoTableDataSource: NSObject, UITableViewDataSource  {
    
    var videoList = VideoList()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return videoList.numberOfVideos()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoListCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = videoList.videoTitleOfIndex(row)
        //        cell.imageView?.image =
        return cell
    }
}