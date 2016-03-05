//
//  ExercisesTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/4.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit

class ExercisesTableViewCell: UITableViewCell {

    var exercies: NSOrderedSet? {
        willSet {
            var items = [String]()
            for exercise in newValue! {
                let exercise = exercise as! Exercise
                items.append(exercise.name!)
            }
            
            if segmentedControl == nil {
                self.segmentedControl = UISegmentedControl(items: items)
                self.segmentedControl?.translatesAutoresizingMaskIntoConstraints = false
                self.segmentedControl?.selectedSegmentIndex = 0
                self.contentView.addSubview(self.segmentedControl!)
                self.contentView.addConstraint(NSLayoutConstraint(item: self.segmentedControl!, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 0))
                self.contentView.addConstraint(NSLayoutConstraint(item: self.segmentedControl!, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
            }
        }
    }
    
    var segmentedControl: UISegmentedControl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
