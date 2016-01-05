//
//  ScrollViewSlider.swift
//  图片轮播
//
//  Created by mac on 15/12/25.
//  Copyright (c) 2015年 MaJT. All rights reserved.
//

import UIKit

protocol GetCurrentPageDelegate: NSObjectProtocol {
    /**
     获得当前浏览图片的页数
     
     - parameter curPage: 当前浏览图片的页数
     */
    func getCurrentPage(curPage: Int)
}

class ScrollViewSlider: UIScrollView {
    
    /// 保存图片
    var imageArray = [String]()
    /// 第一次进入时，当前图片的页数
    var index: Int = 0 {
        didSet {
            let x: CGFloat = CGFloat(index) * self.bounds.size.width
            setContentOffset(CGPointMake(x, 0), animated: true)
            currentPage = index
        }
    }
    /// 滑动图片实时页数
    var currentPage: Int = 0 {
        didSet {
            delegateOfCurPage?.getCurrentPage(currentPage)
        }
    }
    /// 获得滑动图片等页数
    var delegateOfCurPage: GetCurrentPageDelegate?
    
    init(imageArray: [String], frame: CGRect) {
        super.init(frame: frame)
        self.imageArray = imageArray
        initial()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    
    private func initial() {
        delegate = self
        pagingEnabled = true
        bounces = false
        showsHorizontalScrollIndicator = false
        
        for imageName in imageArray {
            let imageView = UIImageView(frame: bounds)
            
            let loadImageQueue = dispatch_queue_create("com.personalCenter.scrollViewSlider.loadImageQueue", nil)
            dispatch_async(loadImageQueue){
                let image = UIImage(named: imageName)
                let scaleImage = UIImage.scaleImage(image!, scale: CGSize(width: self.bounds.size.width, height: self.bounds.size.width * image!.size.height / image!.size.width))
                dispatch_async(dispatch_get_main_queue()){
                    imageView.image = scaleImage
                }
            }
            addSubview(imageView)
        }
        
        let array: NSArray = subviews
        array.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
            let imageView: UIImageView = obj as! UIImageView
            var frame: CGRect = imageView.frame
            frame.origin.x = CGFloat(index) * frame.size.width
            frame.origin.y = 0
//            frame.size.width = self.bounds.size.width
//            frame.size.height = self.bounds.size.width * imageView.image!.size.height / imageView.image!.size.width
            imageView.frame = frame
        }
    }
    
    override func layoutSubviews() {
        contentSize = CGSize(width: bounds.width * CGFloat(imageArray.count), height: bounds.height)
    }

}

extension ScrollViewSlider: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page:CGFloat = scrollView.contentOffset.x/scrollView.bounds.size.width;
        guard currentPage == Int(page) else {
            currentPage = Int(page)
            return 
        }
    }
}
