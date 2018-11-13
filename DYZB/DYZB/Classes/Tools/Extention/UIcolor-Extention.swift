//
//  UIcolor-Extention.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/13.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
}
