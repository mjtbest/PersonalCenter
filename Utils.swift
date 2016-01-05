//
//  Utils.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/5.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

struct Utils {

}

extension UINavigationBar {
    class func setupStyle() {
        let navBar = UINavigationBar.appearance()
        navBar.translucent = false
        navBar.barTintColor = UIColor.NavigationBarColor()
        navBar.tintColor = UIColor.NavagationTintColor()
        navBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.NavagationTintColor() ]
    }
}

extension UIStoryboard {
    class var userDetailInfoStoryboard: UIStoryboard {
        return UIStoryboard(name: "UserDetailInfo", bundle: nil)
    }
}

extension UIColor {
    class func NavigationBarColor() -> UIColor {
        return UIColor(red:0.34, green:0.79, blue:0.90, alpha:0.0)
    }
    
    class func NavagationTintColor() -> UIColor {
        return UIColor.whiteColor()
    }
}

extension UIImage {
    class func scaleImage(image: UIImage, scale size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UILabel {
    /**
     获得UILabel的自适应Rect
     
     - parameter text:  需要自适应的字符串
     - parameter size:  字体的大小
     - parameter width: 最长的宽度
     
     - returns: 自适应的尺寸
     */
    func getRectOfAdaptive(text text: NSString, fontSize size: CGFloat, widthOfAdapvite width: CGFloat) -> CGRect {
        let rect = text.boundingRectWithSize(
            CGSizeMake(width, 0),
            options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont.systemFontOfSize(size)],
            context: nil)
        return rect
    }
    
    /**
     获得UILabel的自适应高度
     
     - parameter size:  字体大小
     - parameter width: 字符串最大长度
     
     - returns: 自适应高度
     */
    func getHeightOfAdaptive(fontSize size: CGFloat, widthOfAdapvite width: CGFloat) -> CGFloat {
        if let text = self.text {
            numberOfLines = 0
            let rect = getRectOfAdaptive(text: text, fontSize: size, widthOfAdapvite: width)
            return rect.size.height
        }
        return 0
    }
    
    /**
     获得UILabel的自适应宽度
     
     - parameter size: 字体的大小
     
     - returns: 自适应宽度
     */
    func getWidthOfAdaptive(fontSize size: CGFloat) -> CGFloat {
        if let text = self.text {
            numberOfLines = 0
            let rect = getRectOfAdaptive(text: text, fontSize: size, widthOfAdapvite: 0)
            return rect.size.width
        }
        return 0
    }
}
