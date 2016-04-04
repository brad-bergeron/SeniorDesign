//
//  ViewController.swift
//  Iconic
//
//  Created by Sam Johnson on 2/22/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    //var viewControllers : [UIViewController] = [FilterViewController, EventTableViewController]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*let filemgr = NSFileManager.defaultManager()
        let dirPaths = file(.DocumentationDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0]
    
        databasePath = docsDir.stringByAppendingString("events.db")
        
        if !filemgr.fileExistsAtPath(databasePath as String){
            let eventsDB = FMDatabase(path: databasePath as String)
            
            if eventsDB == nil{
                printlin("Error: \(eventsDB.lastErrorMessage())")
            }
            
            
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

