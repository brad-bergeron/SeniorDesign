//
//  RemoteNotificationDeepLink.swift
//  Iconic
//
//  Created by Brad Bergeron on 4/25/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit

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
            
            let vc = EventPageViewController()
            //add in code to get the correct View for Event Page
            
            if self.eventID == "Deadpool"{
                
            }
            
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.addSubview(vc.view)
            
            completion(nil)
        }
    }
}