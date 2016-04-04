//
//  SingleEvent.swift
//  Iconic
//
//  Created by admin on 3/23/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation

class SingleEvent : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    var Name : String = ""
    var Location : String = ""
    var List : String  = ""


    class func dynamoDBTableName() -> String! {
        return "Events"
    }
    
    class func hashKeyAttribute() -> String! {
        return "Name"
    }
    
    class func rangeKeyAttribute() -> String! {
        return "Location"
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
    
}