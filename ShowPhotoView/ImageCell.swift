//
//  ImageTextCell.swift
//  CollectionViewLayoutSample
//
//  Created by mjt on 15/12/10.
//  Copyright © 2015年 mjt. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var imageStr: String? {
        didSet {
            let loadImageQueue = dispatch_queue_create("com.personalCenter.imageCell.loadImageQueue", nil)
            dispatch_async(loadImageQueue){
                let scaleImage = UIImage.scaleImage(UIImage(named: self.imageStr!)!, scale: CGSize(width: 100, height: 100))
                dispatch_async(dispatch_get_main_queue()){
                    self.imageView!.image = scaleImage
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
