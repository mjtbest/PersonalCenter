//
//  PersonalCenterViewController.swift
//  PersonalCenter
//
//  Created by mjt on 15/11/29.
//  Copyright © 2015年 mjt. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController {
    
    var bgScrollView: UIScrollView!
    var personalCenterView: UIView!
    var photoScrollVeiw: UIScrollView!
    var addPhotoImgView: UIImageView!
    
    let navBarHeight: CGFloat = 0.0
    var photoIndex:Int = 0
    var cellImgViewWidth: CGFloat!
    var cellImgViewHeight: CGFloat!
    
    lazy var imageArray: [String] = {
        var array: [String] = []
        for i in 0...9 {
            array.append("wallPaper\(i)")
        }
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人空间"
        navigationController?.navigationBarHidden = true
        
        initBackground()
        initBgScrollView()
        initPersonalCenterView()
    }
    
    func initBackground() {
        let bgImgView = UIImageView()
        bgImgView.frame = self.view.frame
        bgImgView.image = UIImage.scaleImage(UIImage(named: "wallPaper1")!, scale: view.bounds.size)
        self.view.addSubview(bgImgView)
    }
    
    func initBgScrollView() {
        bgScrollView = UIScrollView()
        bgScrollView.frame = view.bounds
        bgScrollView.contentSize = CGSize(width: bgScrollView.bounds.width, height: (bgScrollView.bounds.height) * 2 - navBarHeight - 200)
        // 取消到达边界回弹的效果
        bgScrollView.bounces = false
        bgScrollView.delegate = self
        bgScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(bgScrollView)
    }
    
    // MARK: - PersonalCenter View

    func initPersonalCenterView() {
        personalCenterView = UIView()
        personalCenterView.frame = CGRectMake(0, bgScrollView.frame.height - navBarHeight - 200, bgScrollView.bounds.width, bgScrollView.bounds.height)
        personalCenterView.backgroundColor = UIColor.whiteColor()
        personalCenterView.alpha = 0.9
        bgScrollView.addSubview(personalCenterView)
        
//        self.creatPhotoScrollView()
        
        // TODO: - AvatarView
        let avatarViewHeight: CGFloat = 120
        let avatarView = AvatarView(frame: CGRectMake(0, -avatarViewHeight, personalCenterView.frame.width, avatarViewHeight))
        avatarView.nickName = "慢镜头"
        avatarView.gender = "女"
        avatarView.location = "上海, 闵行"
        personalCenterView.addSubview(avatarView)
        
        // TODO: - ShowPhotoView
        let showPhotoView = ShowPhotoView(target: self, imageArray: imageArray, frame: CGRectMake(0, 0, self.view.bounds.width, 200), collectionViewLayout: LineLayout())
        personalCenterView.addSubview(showPhotoView)
        
        // TODO: - UserDetailInfoView
        let identifier = "UserDetailInfoTableViewController"
        let userDetailInfoTableViewController = UIStoryboard.userDetailInfoStoryboard
            .instantiateViewControllerWithIdentifier(identifier)
        let userDetailInfoView = userDetailInfoTableViewController.view
        userDetailInfoView.frame = CGRectMake(0, showPhotoView.frame.maxY + 30, personalCenterView.bounds.width, 200)
        personalCenterView.addSubview(userDetailInfoView)
    }
    
    func creatPhotoScrollView() {
        photoScrollVeiw = UIScrollView()
        let photoScrollViewHeight: CGFloat = 200
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
        let alert = UIAlertController(title: "添加照片", message: "", preferredStyle: .ActionSheet)
        let photographAction = UIAlertAction(title: "拍 照", style: .Default) { (_) -> Void in
            //判断是否获得相机
            guard ((UIImagePickerController.availableMediaTypesForSourceType(.Camera)) == nil) else {
                imgPicker.sourceType = .Camera
                self.presentViewController(imgPicker, animated: true, completion: nil)
                return
            }
        }
        let albumAction = UIAlertAction(title: "相 册", style: .Default) { (_) -> Void in
            //判断是否获得相册
            guard ((UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)) == nil) else {
                imgPicker.sourceType = .PhotoLibrary
                self.presentViewController(imgPicker, animated: true, completion: nil)
                return
            }
        }
        let cancelAcrion = UIAlertAction(title: "取 消", style: .Cancel, handler: nil)
        alert.addAction(photographAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAcrion)
        // 在iPad上alert是一个带箭头的,必须指明弹出位置
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = addPhotoImgView.frame
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Image Edite
    
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

}

extension PersonalCenterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let borderY: CGFloat = scrollView.contentSize.height - bgScrollView.bounds.height
        if offsetY > 0 {
            let alpha = min(1, (offsetY) / (borderY))
            //NavBar透明度渐变
            navigationController!.navigationBar.alpha = alpha
        } else {
            UIView.transitionWithView((navigationController?.navigationBar)!,
                duration: 0.33,
                options: [],
                animations: { () -> Void in
                    self.navigationController?.navigationBar.alpha = 0.0
                }, completion: nil)
        }
    }
}

// MARK: - ImagePicker Delegate

extension PersonalCenterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
}
