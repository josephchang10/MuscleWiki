//
//  AppDelegate.swift
//  MuscleWiki
//
//  Created by 张嘉夫 on 16/3/3.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataVersion = 35

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        application.statusBarStyle = .LightContent
        
        self.importData()
        
        return true
    }
    
    func importData() {
        if NSUserDefaults.standardUserDefaults().objectForKey("dataVersion\(dataVersion)") == nil {
            var dataDict: NSDictionary?
            if let path = NSBundle.mainBundle().pathForResource("Data", ofType: "plist") {
                dataDict = NSDictionary(contentsOfFile: path)
            }
            if let dataDict = dataDict {
                self.deleteAllData("Muscle")
                
                if let muscleList = dataDict["MuscleList"] as? [NSDictionary] {
                    for muscle in muscleList  {
                        if let name = muscle["Name"] as? String {
                            if let newMuscle = NSEntityDescription.insertNewObjectForEntityForName("Muscle", inManagedObjectContext: self.managedObjectContext) as? Muscle {
                                newMuscle.name = name
                                print("保存了\(name)")
                                
                                if let summary = muscle["Description"] as? String {
                                    newMuscle.summary = summary
                                }
                                
                                if let exercises = muscle["Exercises"] as? [NSDictionary] {
                                    for exercise in exercises {
                                        if let name = exercise["Name"] as? String {
                                            if let newExercise = NSEntityDescription.insertNewObjectForEntityForName("Exercise", inManagedObjectContext: self.managedObjectContext) as? Exercise {
                                                newExercise.name = name
                                                
                                                if let descriptions = exercise["Descriptions"] as? [String] {
                                                    for description in descriptions {
                                                        if let newDescription = NSEntityDescription.insertNewObjectForEntityForName("ExerciseStep", inManagedObjectContext: self.managedObjectContext) as? ExerciseStep {
                                                            newDescription.content = description
                                                            newDescription.exercise = newExercise
                                                        }
                                                    }
                                                }
                                                
//                                                if let gifs = exercise["GIFs"] as? [String] {
//                                                    for gif in gifs {
//                                                        if let newGIF = NSEntityDescription.insertNewObjectForEntityForName("GIF", inManagedObjectContext: self.managedObjectContext) as? GIF {
//                                                            newGIF.fileName = "\(gif).gif"
//                                                            newGIF.exercise = newExercise
//                                                        }
//                                                    }
//                                                }
                                                
                                                if let videos = exercise["Videos"] as? [String] {
                                                    for video in videos {
                                                        if let newViedo = NSEntityDescription.insertNewObjectForEntityForName("Video", inManagedObjectContext: self.managedObjectContext) as? Video {
                                                            newViedo.fileName = video
                                                            newViedo.exercise = newExercise
                                                        }
                                                    }
                                                }
                                                
                                                newExercise.muscle = newMuscle
                                            }
                                        }
                                    }
                                }
                                
                                if let buttons = muscle["Buttons"] as? [NSDictionary] {
                                    for button in buttons {
                                        if let touchImage = button["TouchImage"] as? String {
                                            if let newButton = NSEntityDescription.insertNewObjectForEntityForName("Button", inManagedObjectContext: self.managedObjectContext) as? Button {
                                                newButton.touchImageFileName = touchImage
                                                
                                                if let x = button["X"] as? Double {
                                                    newButton.xScaling = x
                                                }
                                                
                                                if let y = button["Y"] as? Double {
                                                    newButton.yScaling = y
                                                }
                                                
                                                if let width = button["Width"] as? Double {
                                                    newButton.widthScaling = width
                                                }
                                                
                                                if let height = button["Height"] as? Double {
                                                    newButton.heightScaling = height
                                                }
                                                
                                                if let front = button["Front"] as? Bool {
                                                    newButton.front = front
                                                }
                                                
                                                newButton.muscle = newMuscle
                                            }
                                        }
                                    }
                                }
                                
//                                if let frontButton = muscle["FrontButton"] as? NSDictionary {
//                                    if let touchImage = frontButton["TouchImage"] as? String {
//                                        if let newButton = NSEntityDescription.insertNewObjectForEntityForName("Button", inManagedObjectContext: self.managedObjectContext) as? Button {
//                                            newButton.touchImageFileName = touchImage
//                                            
//                                            if let x = frontButton["X"] as? Double {
//                                                newButton.xScaling = x
//                                            }
//                                            
//                                            if let y = frontButton["Y"] as? Double {
//                                                newButton.yScaling = y
//                                            }
//                                            
//                                            if let width = frontButton["Width"] as? Double {
//                                                newButton.widthScaling = width
//                                            }
//                                            
//                                            if let height = frontButton["Height"] as? Double {
//                                                newButton.heightScaling = height
//                                            }
//                                            
//                                            newButton.muscle = newMuscle
//                                        }
//                                    }
//                                }
                            }
                        }
                    }
                }
                
                do {
                    try self.managedObjectContext.save()
                    NSUserDefaults.standardUserDefaults().setObject(true, forKey: "dataVersion\(dataVersion)")
                    print("上下文保存成功")
                }catch {
                    print("上下文保存错误")
                }
                
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "social.street.MuscleWiki" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MuscleWiki", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
            
            print("删除了\(entity)")
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

}

