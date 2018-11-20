//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/20.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func getCurrentTime()->String {
    
        let data = NSDate()
        
        let interval = data.timeIntervalSince1970
        
        return "\(interval)"
        
    }
    
}
