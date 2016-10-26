//
//  TrainingSymbolsTableViewCell.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/9/4.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit

class TrainingSymbolsTableViewCell: UITableViewCell {

    @IBAction func symbolButtonTouched(sender: AnyObject) {
        
        if let button = sender as? UIButton {
            
            button.setImage(UIImage(named: "叉"), forState: .Normal)
            
        }
        
    }
    
}
