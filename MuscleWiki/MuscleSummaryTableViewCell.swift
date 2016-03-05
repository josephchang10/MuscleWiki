//
//  MuscleSummaryTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit

class MuscleSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summaryLabel: UILabel!
    var summary: String? {
        willSet {
            self.summaryLabel.text = newValue
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
