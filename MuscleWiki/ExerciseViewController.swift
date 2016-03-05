//
//  ExerciseViewController.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    var contentLength:CGFloat = 320
    var muscle: Muscle!
    var selectedIndex = 0
    
    private let exerciseVideoCellId = "ExerciseVideoTableViewCell"
    private let exerciseTitleCellId = "ExerciseTitleTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: exerciseVideoCellId, bundle: nil), forCellReuseIdentifier: exerciseVideoCellId)
        tableView.registerNib(UINib(nibName: exerciseTitleCellId, bundle: nil), forCellReuseIdentifier: exerciseTitleCellId)
        
        print("\(self.muscle.name)有\(self.muscle.exercises?.count)个训练")
        
        self.makeUI()
    }
    
    func makeUI() {
        self.title = self.muscle.name!
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func segmentedControlAction(sender: UISegmentedControl) {
        self.selectedIndex = sender.selectedSegmentIndex
        self.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: .Automatic)
    }

}

extension ExerciseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if indexPath.section == 1 {
//
//                let cell = tableView.dequeueReusableCellWithIdentifier("ExercisesCell", forIndexPath: indexPath) as! ExercisesTableViewCell
//                
//                cell.exercies = self.muscle.exercises
//                cell.segmentedControl?.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
//                
//                return cell
//            
//        }else if indexPath.section == 2 {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! MuscleSummaryTableViewCell
            
            cell.summary = self.muscle.summary
            
            return cell
        }
        
            let exercise = self.muscle.exercises!.objectAtIndex(indexPath.section-1) as! Exercise
            
            if indexPath.row == 1 {
//                let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseCell", forIndexPath: indexPath) as! ExerciseTableViewCell
                
                let cell = tableView.dequeueReusableCellWithIdentifier(exerciseVideoCellId) as! ExerciseVideoTableViewCell
                
                cell.exercise = exercise
                
                return cell
            }else if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier(exerciseTitleCellId)
                
                cell?.textLabel?.text = exercise.name
                
                return cell!
                
            }else {
                let cell = tableView.dequeueReusableCellWithIdentifier("StepCell", forIndexPath: indexPath) as! ExerciseStepTableViewCell
                
                if let step = exercise.steps?.objectAtIndex(indexPath.row-2) as? ExerciseStep {
                    cell.exerciseStep = step
                }
                
                return cell
            }
//        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return NSLocalizedString("Exercises", comment: "")
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            if let exercises = self.muscle.exercises?.objectAtIndex(section-1) as? Exercise {
                return exercises.steps!.count + 2
            }
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("共有\(self.muscle.exercises!.count+1)个section")
        return self.muscle.exercises!.count+1
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ExerciseVideoTableViewCell {
            if cell.exercise == nil {
                if let exercise = self.muscle.exercises?.objectAtIndex(indexPath.section-1) as? Exercise {
                    cell.exercise = exercise
                }
            }
            cell.videoPlayerView.player.play()
            print("播放视频")
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ExerciseVideoTableViewCell {
            cell.videoPlayerView.player.pause()
            print("暂停播放")
        }
    }
}
