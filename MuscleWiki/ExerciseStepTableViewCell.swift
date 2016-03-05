//
//  ExerciseStepTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/4.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit

class ExerciseStepTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    var exerciseStep: ExerciseStep? {
        willSet {
            self.contentLabel.text = newValue?.content
        }
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
