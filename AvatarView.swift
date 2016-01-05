//
//  AvatarView.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/5.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    /// 头像
    var avatar: UIImageView!
    /// 昵称
    var nickName: String? {
        didSet {
            nickNameLabel.text = nickName
        }
    }
    /// 性别
    var gender: String? {
        didSet {
           genderLabel.text = gender
        }
    }
    /// 所在地
    var location: String? {
        didSet {
            locationLabel.text = location
        }
    }
    
    private var nickNameLabel: UILabel!
    private var genderLabel: UILabel!
    private var locationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        avatar = UIImageView()
        avatar.image = UIImage.scaleImage(UIImage(named: "icon.jpg")!, scale: CGSize(width: 88, height: 88)) // 默认头像
        addSubview(avatar)
        
        nickNameLabel = UILabel()
        nickNameLabel.textAlignment = .Left
        nickNameLabel.textColor = UIColor.blackColor()
        nickNameLabel.font = UIFont.systemFontOfSize(22)
        addSubview(nickNameLabel)
        
        genderLabel = UILabel()
        genderLabel.textAlignment = .Left
        genderLabel.textColor = UIColor.blackColor()
        genderLabel.font = UIFont.systemFontOfSize(14)
        addSubview(genderLabel)
        
        locationLabel = UILabel()
        locationLabel.textAlignment = .Left
        locationLabel.textColor = UIColor.blackColor()
        locationLabel.font = UIFont.systemFontOfSize(14)
        addSubview(locationLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avatarHeight: CGFloat = 88
        avatar.frame = CGRectMake(
            (bounds.size.height - avatarHeight) / 2,
            (bounds.size.height - avatarHeight) / 2,
            avatarHeight, avatarHeight)
        avatar.layer.cornerRadius = avatarHeight / 2
        avatar.layer.masksToBounds = true
        
        if let _ = nickName  {
            let nicknameLabelWidth: CGFloat = 200
            let nicknameLabelHeight: CGFloat = 40
            nickNameLabel.frame = CGRectMake(avatar.frame.maxX + 20, 30, nicknameLabelWidth, nicknameLabelHeight)
        }
        
        if let _ = gender {
            let genderLabelWidth: CGFloat = 30
            let genderLabelHeight: CGFloat = 30
            genderLabel.frame = CGRectMake(avatar.frame.maxX + 35, nickNameLabel.frame.maxY + 3, genderLabelWidth, genderLabelHeight)
        }
        
        if let _ = location {
            let locationLabelWidth: CGFloat = 100
            let locationLabelHeight: CGFloat = 30
            locationLabel.frame = CGRectMake(genderLabel.frame.maxX + 10, genderLabel.frame.minY, locationLabelWidth, locationLabelHeight)
        }
    }
    
    deinit {
        
    }

}
