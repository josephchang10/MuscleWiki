//
//  Exercise+CoreDataProperties.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/4.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var name: String?
    @NSManaged var muscle: Muscle?
    @NSManaged var steps: NSOrderedSet?
    @NSManaged var videos: NSOrderedSet?

}
