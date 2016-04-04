//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
   // var database: FMDatabase? = nil

   /* class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Events.sqlite"))
        }
        return sharedInstance
    }
    
    func addEventData(eventInfo: EventInfo) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO event_info (name, des) VALUES (?, ?)", withArgumentsInArray: [eventInfo.name, eventInfo.des])
        sharedInstance.database!.close()
        return isInserted
    }
   
    func updateEventData(eventInfo: EventInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE event_info SET name=?, des=? WHERE id=?", withArgumentsInArray: [eventInfo.name, eventInfo.des, eventInfo.id])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteEventData(eventInfo: EventInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM event_info WHERE id=?", withArgumentsInArray: [eventInfo.id])
        sharedInstance.database!.close()
        return isDeleted
    }

    func getAllEventData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM event_info", withArgumentsInArray: nil)
        let marrEventInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let eventInfo : EventInfo = EventInfo()
                eventInfo.id = resultSet.stringForColumn("id")
                eventInfo.name = resultSet.stringForColumn("name")
                eventInfo.des = resultSet.stringForColumn("des")
                marrEventInfo.addObject(eventInfo)
            }
        }
        sharedInstance.database!.close()
        return marrEventInfo

    } */
}
