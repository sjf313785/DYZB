//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/20.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    @objc var room_list : [[String : NSObject]]? {//set方法
        didSet{
            guard let room_list = room_list  else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    @objc var tag_name : String = ""
    @objc var icon_name : String = "home_header_normal"
 
    init(dict : [String : NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
