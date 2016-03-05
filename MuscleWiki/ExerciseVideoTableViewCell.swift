//
//  ExerciseVideoTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/4.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit
import VIMVideoPlayer

class ExerciseVideoTableViewCell: UITableViewCell {
    
    var exercise: Exercise? {
        willSet {
            if let videos = newValue?.videos {
                
                if let video = videos.objectAtIndex(0) as? Video {
                    
                    let url = NSBundle.mainBundle().URLForResource(video.fileName!, withExtension: "mp4")
                    self.videoPlayerView.player.setURL(url)
//                    print("播放视频，\(video.fileName)，\(url)")
                }
                
            }
        }
    }
    
    var videoPlayerView: VIMVideoPlayerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.videoPlayerView = VIMVideoPlayerView()
        self.videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.videoPlayerView)
        self.videoPlayerView.addConstraint(NSLayoutConstraint(item: self.videoPlayerView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width))
        self.videoPlayerView.addConstraint(NSLayoutConstraint(item: self.videoPlayerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width * 9 / 16))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.videoPlayerView, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .Bottom, relatedBy: .Equal, toItem: self.videoPlayerView, attribute: .Bottom, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .Top, relatedBy: .Equal, toItem: self.videoPlayerView, attribute: .Top, multiplier: 1, constant: 0))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
