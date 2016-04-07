//
//  FileRead.swift
//  Iconic
//
//  Created by admin on 4/4/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation

class FileRead {
    
    class func exists (path:String) -> Bool {
            return NSFileManager().fileExistsAtPath(path)
    }
    
    
    class func readSecretKey() -> String? {
        var readError:NSError?
        let read: String?
        
        
        do {
            read = try String(contentsOfFile: "/Users/admin/Desktop/AWSSecretKey.csv", encoding: NSUTF8StringEncoding)
            //print("\(read)")
        } catch let error as NSError {
            readError = error
            read = nil
        }
        
        if let error = readError {
            print("readError< \(error.localizedDescription) >")
        }
        
        return read
    }
    
    class func readAccessKey() -> String? {
        var readError:NSError?
        let read: String?
        
        
        do {
            read = try String(contentsOfFile: "/Users/admin/Desktop/AWSAccessKeyId.csv", encoding: NSUTF8StringEncoding)
            //print("\(read)")
        } catch let error as NSError {
            readError = error
            read = nil
        }
        
        if let error = readError {
            print("readError< \(error.localizedDescription) >")
        }
        
        return read
    }
    
    
}