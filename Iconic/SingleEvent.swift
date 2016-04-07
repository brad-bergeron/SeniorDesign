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
    //var Date : String?
    var Event_Type : String?
    //var Filters: String?
    var Event_Price: String?
    //var Time:String?
    var Event_Location:String?
    var Event_Link:String?
    //var details/Des
    
    
    class func dynamoDBTableName() -> String! {
        return "SD_TestTable"
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