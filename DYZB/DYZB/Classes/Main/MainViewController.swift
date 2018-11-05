//
//  MainViewController.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/5.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
    
    private func addChildVC(storyName:String){
        
        guard let VC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController() else {
                return
        }
        addChildViewController(VC)
        
    }
}
