//
//  ExerciseStep+CoreDataProperties.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ExerciseStep {

    @NSManaged var content: String?
    @NSManaged var index: NSNumber?
    @NSManaged var exercise: Exercise?

}
