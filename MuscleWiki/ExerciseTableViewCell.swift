//
//  ExerciseTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit
import Gifu

class ExerciseTableViewCell: UITableViewCell {

    var imageWidth = UIScreen.mainScreen().bounds.width
    var imageHeight: CGFloat {
        return imageWidth * 9 / 16
    }
    
    @IBOutlet weak var imageScrollViewPageControl: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var exercise: Exercise? {
        willSet {
            self.nameLabel.text = newValue?.name
            
//            if let gifs = newValue?.gifs {
//                self.imageScrollView.contentSize = CGSizeMake(imageWidth * CGFloat(gifs.count), imageHeight)
//                self.imageScrollViewPageControl.numberOfPages = gifs.count
//                if gifs.count > 1 {
//                    self.imageScrollViewPageControl.hidden = false
//                }else{
//                    self.imageScrollViewPageControl.hidden = true
//                }
//               self.removeImages()
//                
//                if let gifs = newValue?.gifs {
////                    self.displayImages(gifs)
//                }
//            }
        }
    }
    
//    func displayImages(gifs: NSOrderedSet) {
//            for i in 0..<gifs.count {
//                let gif = gifs[i] as! GIF
//                let imageView = AnimatableImageView(frame: CGRectMake(imageWidth * CGFloat(i), 0, imageWidth, imageHeight))
//                imageView.animateWithImage(named: gif.fileName!)
//                self.imageScrollView.addSubview(imageView)
//            }
//    }
    
    func removeImages() {
        for subview in self.imageScrollView.subviews {
            
            if let imageView = subview as? UIImageView {
                imageView.image = nil
                print("图片设0")
            }
            
            subview.removeFromSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.removeImages()
        print("scrollview有\(self.imageScrollView.subviews.count)个subview")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ExerciseTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let current = scrollView.contentOffset.x/scrollView.frame.width
        self.imageScrollViewPageControl.currentPage = Int(current)
    }
}
