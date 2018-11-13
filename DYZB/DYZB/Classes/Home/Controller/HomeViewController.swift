//
//  HomeViewController.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/1.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

private let titleHeight : CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = { [weak self] in
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleFrame = CGRect(x: 0, y: kStateBarHeight + kNavigationBarHeight, width: kScreenWidth, height: titleHeight)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        
        let contentH = kScreenHeight - (kStateBarHeight + kNavigationBarHeight + 40)
        let frame = CGRect(x: 0, y: kStateBarHeight + kNavigationBarHeight + 40, width: kScreenWidth, height: contentH)
        
        var childVCs = [UIViewController]()
        
        for _ in 0..<4{
            
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), alpha: 1.0)
            childVCs.append(vc)
            
        }
        
        let pageCentenView = PageContentView(frame: frame, childVCs: childVCs, parentViewController: self)
        
        return pageCentenView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
     
    }
    

}

// MARK: - 设置UI界面 -
extension HomeViewController{
    
    private func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    private func setupNavigationBar(){
        
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(image: "image_my_history", clickedImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(image: "btn_search", clickedImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", clickedImage: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}

//pageViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
