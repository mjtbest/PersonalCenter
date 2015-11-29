//
//  PersonalCenterViewController.swift
//  PersonalCenter
//
//  Created by mjt on 15/11/29.
//  Copyright © 2015年 mjt. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var bgScrollView: UIScrollView!
    var personalCenterView: UIView!
    var photoScrollVeiw: UIScrollView!
    var addPhotoImgView: UIImageView!
    
    let TopHeight: CGFloat = 20
    var photoIndex:Int = 0
    var cellImgViewWidth: CGFloat!
    var cellImgViewHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initBackground()
        self.initBgScrollView()
        self.initPersonalCenterView()
    }
    
    func initBackground() {
        let bgImgView = UIImageView()
        bgImgView.frame = self.view.frame
        bgImgView.image = UIImage(named: "wallPaper0.jpg")
        self.view.addSubview(bgImgView)
    }
    
    func initBgScrollView() {
        bgScrollView = UIScrollView()
        bgScrollView.delegate = self
        bgScrollView.frame = CGRectMake(0, TopHeight, self.view.bounds.width, self.view.bounds.height - TopHeight)
        bgScrollView.contentSize = CGSize(width: bgScrollView.bounds.width, height: bgScrollView.bounds.height * 2)
        // 取消到达边界回弹的效果
        bgScrollView.bounces = false
        self.view.addSubview(bgScrollView)
    }
    
    // MARK: - PersonalCenter View

    func initPersonalCenterView() {
        personalCenterView = UIView()
        personalCenterView.frame = CGRectMake(0, bgScrollView.frame.height, bgScrollView.bounds.width, bgScrollView.bounds.height)
        personalCenterView.backgroundColor = UIColor.whiteColor()
        personalCenterView.alpha = 0.9
        bgScrollView.addSubview(personalCenterView)
        
        self.creatAvatarView()
        self.creatPhotoScrollView()
    }
    
    func creatAvatarView() {
        let avatarView = UIView()
        let avatarViewHeight: CGFloat = 120
        // 头像
        let avatarImgView = UIImageView()
        let avatarImgViewHeight: CGFloat = 80
        // 昵称
        let nicknameLabel = UILabel()
        let nicknameLabelWidth: CGFloat = 200
        let nicknameLabelHeight: CGFloat = 40
        // 性别
        let genderLabel = UILabel()
        let genderLabelWidth: CGFloat = 30
        let genderLabelHeight: CGFloat = 30
        // 所在地
        let locationLabel = UILabel()
        let locationLabelWidth: CGFloat = 100
        let locationLabelHeight: CGFloat = 30
        
        avatarView.frame = CGRectMake(0, -avatarViewHeight, personalCenterView.frame.width, avatarViewHeight)
        personalCenterView.addSubview(avatarView)
        // 设置头像
        avatarImgView.frame = CGRectMake((avatarViewHeight - avatarImgViewHeight) / 2, (avatarViewHeight - avatarImgViewHeight) / 2, avatarImgViewHeight, avatarImgViewHeight)
        avatarImgView.layer.cornerRadius = avatarImgViewHeight / 2
        avatarImgView.layer.masksToBounds = true
        avatarImgView.image = UIImage(named: "icon.jpg")
        avatarView.addSubview(avatarImgView)
        // 设置昵称
        nicknameLabel.frame = CGRectMake(avatarImgView.frame.maxX + 20, 30, nicknameLabelWidth, nicknameLabelHeight)
        nicknameLabel.text = "抛出异常"
        nicknameLabel.textAlignment = .Left
        nicknameLabel.textColor = UIColor.blackColor()
        nicknameLabel.font = UIFont.systemFontOfSize(22)
        avatarView.addSubview(nicknameLabel)
        // 设置性别
        genderLabel.frame = CGRectMake(nicknameLabel.frame.minX + 20, nicknameLabel.frame.maxY + 3, genderLabelWidth, genderLabelHeight)
        genderLabel.text = "男"
        genderLabel.textAlignment = .Left
        genderLabel.textColor = UIColor.blackColor()
        genderLabel.font = UIFont.systemFontOfSize(14)
        avatarView.addSubview(genderLabel)
        // 设置所在地
        locationLabel.frame = CGRectMake(genderLabel.frame.maxX + 10, genderLabel.frame.minY, locationLabelWidth, locationLabelHeight)
        locationLabel.text = "上海，闵行"
        locationLabel.textAlignment = .Left
        locationLabel.textColor = UIColor.blackColor()
        locationLabel.font = UIFont.systemFontOfSize(14)
        avatarView.addSubview(locationLabel)
    }
    
    func creatPhotoScrollView() {
        photoScrollVeiw = UIScrollView()
        let photoScrollViewHeight: CGFloat = 200
        photoScrollVeiw.delegate = self
        photoScrollVeiw.bounces = false
        photoScrollVeiw.frame = CGRectMake(0, 0, personalCenterView.bounds.width, photoScrollViewHeight)
        photoScrollVeiw.contentSize = CGSize(width: personalCenterView.bounds.width * 3, height: photoScrollViewHeight)
        photoScrollVeiw.backgroundColor = UIColor.lightGrayColor()
        personalCenterView.addSubview(photoScrollVeiw)
        // 添加图片按钮
        cellImgViewWidth = photoScrollViewHeight
        cellImgViewHeight = photoScrollViewHeight
        addPhotoImgView = UIImageView()
        addPhotoImgView.frame = CGRectMake(0, 0, cellImgViewWidth, cellImgViewHeight)
        addPhotoImgView.image = UIImage(named: "add_photo.png")
        addPhotoImgView.userInteractionEnabled = true
        addPhotoImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "addPhoto"))
        photoScrollVeiw.addSubview(addPhotoImgView)
    }
    
    func addPhoto() {
        // 初始化UIImagePickerController
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        let alert = UIAlertController(title: "添加照片", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let photographAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (_) -> Void in
            //判断是否获得相机
            if ((UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)) != nil) {
                imgPicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imgPicker, animated: true, completion: nil)
            }
        }
        let albumAction = UIAlertAction(title: "从相册中选取", style: UIAlertActionStyle.Default) { (_) -> Void in
            //判断是否获得相册
            if ((UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)) != nil) {
                imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(imgPicker, animated: true, completion: nil)
            }
        }
        let cancelAcrion = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(photographAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAcrion)
        // 在iPad上alert是一个带箭头的,必须指明弹出位置
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = addPhotoImgView.frame
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let dic = info as NSDictionary
        // 编辑过后的图片
        let editedImage = dic.objectForKey("UIImagePickerControllerEditedImage") as? UIImage
        let imgView = UIImageView()
        imgView.frame = CGRectMake(CGFloat(photoIndex) * cellImgViewWidth, 0, cellImgViewWidth, cellImgViewHeight)
        photoScrollVeiw.addSubview(imgView)
        // 将裁减后的照片传给imageView
        let scaledWidth: CGFloat = (editedImage?.size.width > 800) ? 800 : (editedImage?.size.width)!
        let scaledHeight: CGFloat = scaledWidth * (editedImage!.size.height / editedImage!.size.width)
        let scaledImg = self.scaleFromImage(editedImage!, size: CGSize(width: scaledWidth, height: scaledHeight))
        imgView.image = scaledImg
        imgView.tag = photoIndex
        // 自定义手势
        imgView.userInteractionEnabled = true
        let tap = CoustomTapGesture(target: self, action: "showBigPhoto:")
        tap.imgView = imgView
        imgView.addGestureRecognizer(tap)
        // 图片索引加一
        photoIndex++
        // 更新添加图标的位置
        addPhotoImgView.frame = CGRectMake(CGFloat(photoIndex) * cellImgViewWidth, 0, cellImgViewWidth, cellImgViewHeight)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 图片全屏的点击事件
    func showBigPhoto(sender: CoustomTapGesture) {
        let orignImgView = sender.imgView
        let fullScreenView = UIImageView()
        let maskView = UIView()
        
        maskView.backgroundColor = UIColor.blackColor()
        fullScreenView.image = orignImgView?.image
        maskView.addSubview(fullScreenView)
        
        // 只有添加到self.view上才能实现全屏
        self.view.addSubview(maskView)
        // 实现自定义动画
        fullScreenView.userInteractionEnabled = true
        let tap = CoustomTapGesture(target: self, action: "recoveryPhoto:")
        tap.oldImgView = orignImgView
        tap.imgView = fullScreenView
        tap.maskView = maskView
        fullScreenView.addGestureRecognizer(tap)
        // 全屏显示动画
        maskView.frame = orignImgView!.frame
        maskView.alpha = 0
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            maskView.frame = self.view.frame
            maskView.alpha = 1
            let imgW: CGFloat = maskView.bounds.width
            let imgH: CGFloat = imgW * orignImgView!.frame.height / orignImgView!.frame.width
            fullScreenView.frame = CGRectMake(0, (maskView.bounds.height - imgH) / 2, imgW, imgH)
            self.view.bringSubviewToFront(maskView)
        })
    }
    
    // 图片恢复原始位置的点击事件
    func recoveryPhoto(sender: CoustomTapGesture) {
        let imgView = sender.oldImgView
        let fullScreenView = sender.imgView
        let maskView = sender.maskView
        // 必须添加到原始的View上才能恢复原始位置
        self.photoScrollVeiw.addSubview(fullScreenView!)
        // 实现自定义手势
        let tap = CoustomTapGesture(target: self, action: "showBigPhoto:")
        tap.oldImgView = fullScreenView
        tap.imgView = imgView
        fullScreenView!.addGestureRecognizer(tap)
        // 图片恢复动画
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            maskView?.removeFromSuperview()
            fullScreenView!.frame = imgView!.frame
        })
    }
    
    // 裁剪图片尺寸
    func scaleFromImage(image:UIImage, size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
