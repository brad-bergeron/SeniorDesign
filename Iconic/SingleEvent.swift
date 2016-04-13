//
//  SingleEvent.swift
//  Iconic
//
//  Created by admin on 3/23/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation

class SingleEvent : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    var Event_Name : String?
    var Event_Date : String?
    var Event_Type : String?
    var Event_Organization : String?
    var Event_Filters: [String]?
    var Event_Price: String?
    var Event_Time:String?
    var Event_Location:String?
    var Event_Link:String?
    var Event_Photo_Link : String?
    
    
    class func dynamoDBTableName() -> String! {
        return "Iconic_Events"
    }
    
    class func hashKeyAttribute() -> String! {
        return "Event_Name"
    }
    
    /*class func rangeKeyAttribute() -> String! {
    return "Location"
    }*/
    
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
    
    
}