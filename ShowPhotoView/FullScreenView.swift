//
//  FullScreenView.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/4.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

class FullScreenView: UIView {
    
    var mask: UIView!
    var imageArray: [String] = [String]()
    var index: Int = 0

    var slider: ScrollViewSlider!
    private var pageLabel: UILabel!
    
    
    init(imageArray: [String], index: Int, frame: CGRect) {
        super.init(frame: frame)
        
        self.imageArray = imageArray
        self.index = index
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     设置UI
     */
    func setupUI() {
        mask = UIView()
        mask.backgroundColor = UIColor.blackColor()
        mask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideView"))
        addSubview(mask)
        
        let sliderW: CGFloat = bounds.size.width
        let sliderH: CGFloat = bounds.size.height * 3 / 5
        let sliderX: CGFloat = 0
        let sliderY: CGFloat = (bounds.size.height - sliderH) / 2
        slider = ScrollViewSlider(
            imageArray: imageArray,
            frame: CGRectMake(sliderX, sliderY, sliderW, sliderH))
        slider.index = index
        slider.delegateOfCurPage = self
        mask.addSubview(slider)
        
        pageLabel = UILabel()
        pageLabel.backgroundColor = UIColor.clearColor()
        pageLabel.text = "\(index + 1)/\(imageArray.count)"
        pageLabel.textAlignment = .Left
        pageLabel.textColor = UIColor.whiteColor()
        pageLabel.font = UIFont.systemFontOfSize(18)
        mask.addSubview(pageLabel)
    }

    override func layoutSubviews() {
        mask.frame = UIScreen.mainScreen().bounds
        pageLabel.frame = CGRectMake(15, 20, 100, 30)
    }
    
    /**
     点击遮罩层是移除本页面
     */
    func hideView() {
        UIView.transitionWithView(self, duration: 0.33,
            options: [],
            animations: { () -> Void in
                self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
        }
    }
    
    /**
     当对象消除时，置空数组
     */
    deinit {
        imageArray = []
    }
    
}

// MARK: - GetCurrentPageDelegate

extension FullScreenView: GetCurrentPageDelegate {
    func getCurrentPage(curPage: Int) {
        pageLabel.text = "\(curPage + 1)/\(imageArray.count)"
    }
}
