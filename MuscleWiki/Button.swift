//
//  Button.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Button: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var imageView: UIImageView?
    
    var x:CGFloat {
        
        if let xScaling = xScaling {
            
            if let imageView = imageView {
                return CGFloat(Double(imageView.bounds.width) * xScaling.doubleValue)
            }
            
            
        }
        
        return 0
    }
    
    var y:CGFloat {
        
        if let yScaling = yScaling {
            
            if let imageView = imageView {
                return CGFloat(Double(imageView.bounds.height) * yScaling.doubleValue)
            }
            
        }
        
        return 0
    }
    
    var width:CGFloat {
        
        if let widthScaling = widthScaling {
            
            if let imageView = imageView {
                return CGFloat(Double(imageView.bounds.width) * widthScaling.doubleValue)
            }
            
        }
        
        return 0
    }
    
    var height:CGFloat {
        
        if let heightScaling = heightScaling {
            
            if let imageView = imageView {
                return CGFloat(Double(imageView.bounds.height) * heightScaling.doubleValue)
            }
            
        }
        
        return 0
    }

}
