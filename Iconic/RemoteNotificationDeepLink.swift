//
//  RemoteNotificationDeepLink.swift
//  Iconic
//
//  Created by Brad Bergeron on 4/25/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit

//This is for the link so the link should be gfIconic://event/"The name of the vent"
//This allows us to determine if the user is coming into the app for an event 
//of just for the home page 
let RemoteNotificationDeepLinkApp : String = "event"

class RemoteNotificationDeepLink: NSObject {
    
    var event : String = ""
    
    class func create(userInfo : [NSObject : AnyObject]) -> RemoteNotificationDeepLink? {
        
        let info = userInfo as NSDictionary
        
        let eventID = info.objectForKey(RemoteNotificationDeepLinkApp) as! String
        
        var ret : RemoteNotificationDeepLink? = nil
        if !eventID.isEmpty{
            ret = RemoteNotificationDeepLinkEvent(eventStr: eventID)
        }
        return ret
    }
    
    private override init(){
        self.event = ""
        super.init()
    }
    
    private init(eventStr: String){
        
        self.event = eventStr
        super.init()
    }
    
    final func trigger(){
        
        dispatch_async(dispatch_get_main_queue()){
            //NSLog("Triggering Deep Link - %"@", self)
            self.triggerImp(){
                 (passedData) in
            
            }
        }
    }
    
    private func triggerImp(completion: ((AnyObject?)->(Void))){
        completion(nil)
    }
    
}

class RemoteNotificationDeepLinkEvent : RemoteNotificationDeepLink{
    
    var eventID : String!
    
    override init(eventStr: String){
        
        self.eventID = eventStr
        super.init(eventStr: eventStr)
    }
    
    private override func triggerImp(completion: ((AnyObject?)->(Void))){
        
        super.triggerImp(){
            (passedData) in
            
            //let vc = EventTableViewController()
            //add in code to get the correct View for Event Page
            
            linkedIntoEvent = true
            EventLinked = self.eventID
            
            //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            //appDelegate.window?.addSubview(vc.view)
            
            completion(nil)
        }
    }
}