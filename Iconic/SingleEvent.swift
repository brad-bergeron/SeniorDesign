//
//  SingleEvent.swift
//  Iconic
//
//  Created by Brad Bergeron on 3/23/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit

//This is our DataModel it needs to include all the colmuns 
//from the DynamoDB Dataabse otherwise it wont be 
//able to pull in data. The foormat of this datamodel is important
//AWSDyanmoDBModel wont work without it
class SingleEvent : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    var Event_Name : String?
    var Event_Date_Formatted : String?
    var Event_Type : String?
    var Event_Organization : String?
    var Event_Filters: [String]?
    var Event_Price: String?
    var Event_Time:String?
    var Event_Location:String?
    var Event_Link:String?
    var Event_Picture_Link : String?
    var Event_Picture : UIImage?
    var Event_NSDate : NSDate?
    
    
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