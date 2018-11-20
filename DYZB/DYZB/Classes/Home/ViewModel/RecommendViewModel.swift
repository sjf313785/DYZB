//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/20.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

class RecommendViewModel {

    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

extension RecommendViewModel {
    
    func requestData() {
        
        //1.请求推荐数据

        //2.请求颜值数据
        
        //3.请求剩余数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", paramters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String : NSObject] else{ return }
            
            guard let dictArray = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            for dict in dictArray {
                
                let group = AnchorGroup(dict: dict)
                
                self.anchorGroups.append(group)
                
            }
            
            for group in self.anchorGroups{
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
            }
            
            
        }
        
    }
    
}
