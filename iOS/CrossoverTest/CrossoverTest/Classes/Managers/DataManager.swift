//
//  DataManager.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager: NSObject {
    
/*
 
    static let sharedInstance = DataManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init() {
        //do nothing
    }
    
    // insert New Alarm
    class func saveAlarm(alarm: BCAlarm) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        // alarm entity
        let entity = NSEntityDescription.entityForName("Alarm",
                                                       inManagedObjectContext:managedContext)
        let alarmData = NSManagedObject(entity: entity!,
                                        insertIntoManagedObjectContext: managedContext)
        
        // generate alarm data
        alarmData.setValue(alarm.name, forKey: "name")
        alarmData.setValue(alarm.date, forKey: "date")
        
        //save alarm data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    // insert New Alarm
    class func updateAlarm(alarm: BCAlarm, oldName: String) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "name == %@", oldName)
        
        let fetchRequest = NSFetchRequest(entityName: "Alarm")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [Alarm]
            if results.count > 0 {
                let alarmData = results.first!
                alarmData.setValue(alarm.name, forKey: "name")
                alarmData.setValue(alarm.date, forKey: "date")
            }
        } catch {
            print("Error on object update")
        }
        
        //update alarm data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not update \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    // delete Alarm
    class func deleteAlarm(alarm: BCAlarm) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "name == %@", alarm.name)
        
        let fetchRequest = NSFetchRequest(entityName: "Alarm")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [Alarm]
            if results.count > 0 {
                if let alarmObject = results.first {
                    managedContext.deleteObject(alarmObject)
                }
            }
        } catch {
            print("Error on object delete")
        }
        
        //update alarm data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    class func fetchAlarms() -> [BCAlarm] {
        
        var alarms:[BCAlarm] = []
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        // fetch request
        let fetchRequest = NSFetchRequest(entityName: "Alarm")
        
        
        //save alarm data
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [Alarm]
            
            print(result)
            
            if result.count > 0 {
                for object in result {
                    
                    let alarm = BCAlarm()
                    alarm.name = object.name
                    alarm.date = object.date
                    
                    alarms.append(alarm)
                    
                }
            }
            
            return alarms
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return alarms
    }
     
     
    */
 
}