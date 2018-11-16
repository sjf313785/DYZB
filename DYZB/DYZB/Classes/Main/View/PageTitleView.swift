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
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


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
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
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
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
        currentIndex = currentLabel.tag
        //处理下部黄条
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理做事情
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
    
    private func setupBottomMenuAndScrollLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else{
            return
        }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
        contentView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineH, width: firstLabel.frame.width, height: scrollLineH)

    }
}
//对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress, alpha: 1.0)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress, alpha: 1.0)
        
        currentIndex = targetIndex
    }
}
