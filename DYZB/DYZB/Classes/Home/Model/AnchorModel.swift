//
//  AnchorModel.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/20.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    @objc var room_id : Int = 0
    @objc var vertical_src : String = ""
    @objc var isVertical : Int = 0 //0：电脑直播 1：手机直播
    @objc var room_name : String = ""
    @objc var nickname : String = ""
    @objc var online : Int = 0
    
    init(dict : [String : NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
