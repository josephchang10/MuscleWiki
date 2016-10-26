//
//  ViewController.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit
import CoreData
import ElasticTransition

class ViewController: UIViewController {
    
    @IBOutlet weak var frontMuscleImageView: UIImageView!
    let transition = ElasticTransition()
    var front = true
    var bodyImageName: String {
        if front {
            return "body_front"
        }else{
            return "body_back"
        }
    }
    
    var muscles = [Muscle]() {
        didSet {
            self.putButtons()
        }
    }
    
    func putButtons() {
        
        //先移除之前的
        for subview in self.frontMuscleImageView.subviews {
            subview.removeFromSuperview()
        }
        
        for muscle in muscles {
            var i = 0
            if let buttons = muscle.buttons {
                
                for button in buttons {
                    let b = button as! Button
                    
                    if b.front!.boolValue == front {
                        b.imageView = frontMuscleImageView
                        let button = MuscleButton(frame: CGRectMake(b.x,b.y,b.width,b.height))
                        print("添加按钮在位置：\(button.frame)，是第\(i)块肌肉")
                        button.addTarget(self, action: #selector(ViewController.tapMuscle(_:)), forControlEvents: .TouchUpInside)
                        //                    button.backgroundColor = UIColor.redColor()
                        button.imageName = b.touchImageFileName
                        button.muscle = muscle
//                        button.tag = i //标明是哪块肌肉
                        self.frontMuscleImageView.addSubview(button)
                    }
                    
                }
                
                
            }
            i += 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("全身图位置：\(self.frontMuscleImageView.frame)")
        transition.edge = .Right
        
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor(red: 42/255, green: 61/255, blue: 78/255, alpha: 1).CGColor, UIColor(red: 30/255, green: 35/255, blue: 54/255, alpha: 1).CGColor]
        self.view.layer.insertSublayer(gradient, atIndex: 0)
        
        self.getData()
    }
    
    func getData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Muscle")
        
        do{
            self.muscles = try managedContext.executeFetchRequest(fetchRequest) as! [Muscle]
            print("获取到了\(self.muscles.count)个肌肉数据")
        } catch let error as NSError {
            print("获取肌肉数据 error : \(error) \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    func tapMuscle(sender: MuscleButton) {
        print("按了\(self.muscles[sender.tag].name)")
        
//        let muscle = self.muscles[sender.tag]
        
        if let touchImageFileName = sender.imageName {
            self.frontMuscleImageView.image = UIImage(named: touchImageFileName)
            self.performSegueWithIdentifier("Exercises", sender: sender.muscle)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Exercises" {
            segue.destinationViewController.transitioningDelegate = transition
            segue.destinationViewController.modalPresentationStyle = .Custom
            
            let nav = segue.destinationViewController as! UINavigationController
            if let exercises = nav.topViewController as? ExerciseViewController {
                exercises.muscle = sender as? Muscle
            }
        }
    }

    @IBAction func flip(sender: AnyObject) {
        self.front = !self.front
        UIView.transitionWithView(self.frontMuscleImageView, duration: 0.4, options: .TransitionFlipFromRight, animations: { () -> Void in
            self.frontMuscleImageView.image = UIImage(named: self.bodyImageName)
            }) { (finished) -> Void in
                print("翻转完成")
                self.putButtons()
        }
    }
}
