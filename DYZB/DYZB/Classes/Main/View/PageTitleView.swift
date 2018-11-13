//
//  PageTitleView.swift
//  DYZB
//
//  Created by 史俊峰 on 2018/11/12.
//  Copyright © 2018年 史俊峰. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
     func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let scrollLineH : CGFloat = 2
private var currentIndex : Int = 0

class PageTitleView: UIView {

    private var titles : [String]
    private var titleLabels : [UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    
    private lazy var contentView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI() {
        
        addSubview(contentView)
        contentView.frame = self.bounds
        
        setupTitleLabels()
        
        setupBottomMenuAndScrollLine()
        
    }
    
    private func setupTitleLabels(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - scrollLineH
        let LabelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.gray
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)

            
            label.frame = CGRect(x: labelX, y: LabelY, width: labelW, height: labelH)
            contentView.addSubview(label)
            titleLabels.append(label)
            
            //label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClicked(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    @objc private func titleLabelClicked(tapGes : UIGestureRecognizer){
        
        //处理titleLabel
        guard let currentLabel = tapGes.view as? UILabel else{
        
            return
            
        }
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        currentIndex = currentLabel.tag
        //处理下部黄条
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理做事情
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
    
    private func setupBottomMenuAndScrollLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else{
            return
        }
        firstLabel.textColor = UIColor.orange
        contentView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineH, width: firstLabel.frame.width, height: scrollLineH)

    }
}
