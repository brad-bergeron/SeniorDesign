//
//  Event.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/5/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class Event {
    // MARK: Properties 
    var eventName: String
    var eventLoc: String
    var eventDate: NSDate
    var eventPhoto: UIImage?
    var eventCost: Float?
    var eventLink: String
    var eventDetails: String
    var eventFilterData: [String]?
    
    // MARK: Initializations 
    init?(eventName: String, eventLoc: String, eventDate: NSDate, eventPhoto: UIImage?, eventCost: Float?, eventLink: String, eventDetails: String){
        self.eventName = eventName
        self.eventLoc = eventLoc
        self.eventDate = eventDate
        self.eventPhoto = eventPhoto
        self.eventCost = eventCost
        self.eventLink = eventLink
        self.eventDetails = eventDetails
        self.eventFilterData = nil
        
        if(eventName.isEmpty || eventCost < 0 || eventLink.isEmpty || eventLoc.isEmpty) {
            return nil
        }
    }
} 