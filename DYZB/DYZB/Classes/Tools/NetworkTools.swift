//
//  NetworkTools.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/20.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    class func requestData(type : MethodType, URLString : String, paramters : [String : String]? = nil, finishCallBack : @escaping (_ result : Any)->()) {
    
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: paramters).responseJSON { (response) in
            
            guard let result = response.result.value else{
                
                print(response.result.error ?? "未知错误")
                
                return
                
            }
            
            finishCallBack(result)
            
        }
        
    }
    
}
