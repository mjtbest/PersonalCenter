//
//  ShowPhotoViewController.swift
//  CollectionViewLayoutSample
//
//  Created by mjt on 16/1/4.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

class ShowPhotoView: UICollectionView {
    
    /// 开放的存储图片等接口
    var imageArray: [String]!
    private var superVC: UIViewController!
    private let imageCellIdentifier: String = "ImageCell"
    
    init(target: UIViewController, imageArray: [String], frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor.clearColor()
        dataSource  = self
        delegate = self
        registerClass(ImageCell.self, forCellWithReuseIdentifier: imageCellIdentifier)

        superVC = target
        self.imageArray = imageArray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UICollectionView Delegate / DataSource

extension ShowPhotoView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(imageCellIdentifier, forIndexPath: indexPath) as! ImageCell
        cell.imageStr = imageArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let fullScreenView = FullScreenView(
            imageArray: imageArray,
            index: indexPath.row,
            frame: superVC.view.bounds)
        fullScreenView.alpha = 0.0
        superVC.view.addSubview(fullScreenView)
        
        UIView.transitionWithView(fullScreenView, duration: 0.33,
            options: [.CurveEaseOut],
            animations: { () -> Void in
                fullScreenView.alpha = 1.0
            }, completion: nil)
    }

}
