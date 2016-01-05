//
//  ShowPhotoViewController.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/4.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

class ShowPhotoViewController: UIViewController {
    
    var photoScrollVeiw: UIScrollView!
    var addPhotoImgView: UIImageView!
    let TopHeight: CGFloat = 20
    var photoIndex:Int = 0
    var cellImgViewWidth: CGFloat!
    var cellImgViewHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        creatPhotoScrollView()
    }

    func creatPhotoScrollView() {
        photoScrollVeiw = UIScrollView()
        let photoScrollViewHeight: CGFloat = 200
        photoScrollVeiw.bounces = false
        photoScrollVeiw.frame = CGRectMake(0, 0, view.bounds.width, photoScrollViewHeight)
        photoScrollVeiw.contentSize = CGSize(width: view.bounds.width * 3, height: photoScrollViewHeight)
        photoScrollVeiw.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(photoScrollVeiw)
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
        let photographAction = UIAlertAction(title: "拍 照", style: UIAlertActionStyle.Default) { (_) -> Void in
            //判断是否获得相机
            guard ((UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)) != nil) else {
                imgPicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imgPicker, animated: true, completion: nil)
                return
            }
        }
        let albumAction = UIAlertAction(title: "相 册", style: UIAlertActionStyle.Default) { (_) -> Void in
            //判断是否获得相册
            if ((UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)) != nil) {
                imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(imgPicker, animated: true, completion: nil)
                
            }
        }
        let cancelAcrion = UIAlertAction(title: "取 消", style: UIAlertActionStyle.Cancel, handler: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - ImagePicker Delegate

extension ShowPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
