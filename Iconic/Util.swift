//
//  Util.swift
//  Iconic
//
//  Created by admin on 3/2/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    
    class func getPath(fileName: String) -> String {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask)[0]
        let fileUrl = documentsURL.URLByAppendingPathComponent(fileName)
        
        return fileUrl.path!
    }
    
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName as String)
        
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(dbPath) {
            let documentsURL = NSBundle.mainBundle().resourceURL
            let fromPath = documentsURL!.URLByAppendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItemAtPath(fromPath.path!, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            let alert: UIAlertController = UIAlertController()
            if (error != nil){
                alert.title = "Error Occured"
                alert.message = error?.localizedDescription
            } else {
                alert.title = "Succesfully Copy"
                alert.message = "Your Database copy successfully"
            }
            
        }
    }
}
