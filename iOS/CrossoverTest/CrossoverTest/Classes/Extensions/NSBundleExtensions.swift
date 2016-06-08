//
//  NSBundleExtensions.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation

extension NSBundle {
  func stringForKey(key: String) -> String? {
    return infoDictionary?[key] as? String
  }


  class func stringFromFile(filename: String) -> String? {
    let path = NSBundle.mainBundle().pathForResource(filename, ofType: "txt")
    do {
        let text = try String(contentsOfFile: path!, encoding:NSUTF8StringEncoding)
        return text
    } catch let error as NSError  {
        print("Could not get file contents \(error), \(error.userInfo)")
    }
    
    return nil
  }
}