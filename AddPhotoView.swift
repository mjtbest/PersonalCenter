//
//  AddPhotoView.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/5.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

class AddPhotoView: UICollectionView {
    
    var addPhoto: UIImageView!

    var photoIndex:Int = 0
    var cellImgViewWidth: CGFloat!
    var cellImgViewHeight: CGFloat!

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    deinit {
        
    }

}
