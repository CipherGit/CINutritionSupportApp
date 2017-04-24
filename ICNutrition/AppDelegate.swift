//
//  AppDelegate.swift
//  ICNutrition
//
//  Created by Justin Peña on 24/2/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import CSV
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
        if !isPreloaded {
            deleteContents(entityName: "Guideline")
            preloadGuidelines(fileName: "cccs_cpg")
            
            //Preload of Test patient, ward, and disease
            let testPatient = Patient(context: context!)
            testPatient.patientID = 1
            testPatient.name = "Justin"
            testPatient.age = 25
            testPatient.gender = "Male"
            testPatient.height = 170
            testPatient.weight = 60
            
            //Create admitDate
            let dateString = "2017-04-16 16:30:00"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let admitDate = dateFormatter.date(from: dateString)
            testPatient.admitDate = admitDate as NSDate?
            
            //Create Test ICUWard
            let testWard = ICUWard(context: context!)
            testWard.icuWardID = 1
            testWard.wardName = "Freedom"
            testWard.wardToOne_Patient = testPatient
            
            //Create Test Disease
            let testDisease = Disease(context: context!)
            testDisease.diseaseName = "Respiratory Distress Syndrome"
            testDisease.diseaseNotes = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
            testDisease.diseaseSeverity = "Acute"
            
            //Set relationsips
            testPatient.addToPatientToMany_Disease(testDisease)
            testDisease.disToOne_Patient = testPatient
            testPatient.patientToOne_Ward = testWard
            
            do {
                try testWard.managedObjectContext?.save()
                try testDisease.managedObjectContext?.save()
                try testPatient.managedObjectContext?.save()
            } catch {
                NSLog("Error in saving test ward, test disease and test patients")
            }
            
            defaults.set(true, forKey: "isPreloaded")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ICNutritionCoreModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func preloadGuidelines (fileName:String) {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let csvFile = try CSV(string: contents, hasHeaderRow: true)
                let context = persistentContainer.viewContext
                var gID = 0
                
                let source = GLSource(context: context)
                var sourceAdd = false
                for row in csvFile {
                    if sourceAdd == false {
                        source.glName = row[0]
                        source.glSourceID = Int64(gID)
                        sourceAdd = true
                    }
                    let guideline = Guideline(context: context)
                    guideline.gID = Int64(gID)
                    guideline.identifier = row[1]
                    guideline.category = row[2]
                    guideline.shortDesc = row[3]
                    guideline.fullDesc = row[4]
                    guideline.glToOne_GLSource = source
                    source.addToGlsToMany_gl(guideline)
                    
                    let index = Index(context: context)
                    index.indexID = Int64(gID)
                    index.keywords = row[5]
                    index.idxToOne_GL = guideline
                    
                    do {
                        try guideline.managedObjectContext?.save()
                        try index.managedObjectContext?.save()
                    } catch {
                        NSLog("Error - Failed to save: %@", String(guideline.identifier!))
                    }
                    
                    gID += 1
                }
                NSLog("Successfully Loaded: %@", fileName)
            } catch {
                NSLog("Warning Core Data Empty - Failed to load: %@", fileName)
            }
        }
    }
    
    func deleteContents(entityName:String) {
        do {
            let context = persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            //Add more cases to delete other tables
            switch entityName {
                case "Guideline":
                    let guidelines = try (context.fetch(request)) as! [Guideline]
                    for guideline in guidelines {
                        context.delete(guideline)
                    }
                default:
                    NSLog("Table %@ does not match any existing tables", entityName)
            }
        } catch {
            NSLog("Error deleting table data: %@", entityName)
        }
    }
}

