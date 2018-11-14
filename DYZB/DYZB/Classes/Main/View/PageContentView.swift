//
//  PageContentView.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/13.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    private var childVCs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    private lazy var collectionView : UICollectionView = { [weak self] in //闭包里面用弱引用
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
        
    }()
    
    init(frame: CGRect,childVCs : [UIViewController], parentViewController : UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    
    private func setupUI(){
        
        for vc in childVCs {
            parentViewController?.addChildViewController(vc)
        }
        
        //添加uiCollectionView用于在cell上存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

extension PageContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let child = childVCs[indexPath.item]
        
        child.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(child.view)
        
        return cell
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{
            progress = (currentOffsetX / scrollViewW) - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                sourceIndex = targetIndex
            }
            
        }else{
            progress = 1 -  (currentOffsetX / scrollViewW) - floor(currentOffsetX / scrollViewW)
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = sourceIndex + 1
            if sourceIndex >= childVCs.count{
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}
//对外暴露的借口，用于操作PageContentView
extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
     
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX, y:0), animated: false)
        
    }
}
