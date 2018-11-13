//
//  UIBarbuttonItem-Extention.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/12.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
  
    //1.便利构造函数convenience 2.必须用系统的某一个函数init(customView: btn)
    convenience init(image:String, clickedImage:String, size: CGSize){
        
        let btn = UIButton()
        btn.setImage(UIImage(named:image), for: .normal)
        btn.setImage(UIImage(named:clickedImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        self.init(customView: btn)
        
    }
    
}
