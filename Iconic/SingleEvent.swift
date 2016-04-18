//
//  SingleEvent.swift
//  Iconic
//
//  Created by admin on 3/23/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit

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
    var Event_Picture_Link : String?
    var Event_Picture : UIImage?
    
    
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