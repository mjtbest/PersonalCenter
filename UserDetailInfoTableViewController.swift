//
//  UserDetailInfoTableViewController.swift
//  PersonalCenter
//
//  Created by mjt on 16/1/5.
//  Copyright © 2016年 mjt. All rights reserved.
//

import UIKit

final class UserDetailInfoTableViewController: UITableViewController {
    
    @IBOutlet var cells: [UITableViewCell]!
    @IBOutlet var contentsLabel: [UILabel]!
    lazy var contents: [String] = {
       return ["乐活族、爱码士", "音乐、电影、法语、郊游", "绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害绿色无公害"]
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        var cellsHeight = [CGFloat]()
        let cells: NSArray = self.cells
        let labels: NSArray = contentsLabel
        
        labels.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
            let label = obj as! UILabel
            label.text = self.contents[index]
            label.textColor = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(14)
            // TODO: - 当现实内容较大时，显示不全，通过扩展UILabel得到自适应高度，并不成功
            // 静态方式显示TableView，cell的高度好像不能动态改变
            // 重新设置每一个cell的高度，然后reload仍然没用
            // 求解。。。。。
            label.frame.size.height = label.getHeightOfAdaptive(fontSize: 4, widthOfAdapvite: label.bounds.width)
            cellsHeight.append(label.frame.size.height)
        }
        
        cells.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
            let cell = obj as! UITableViewCell
            cell.frame.size.height = cellsHeight[index]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
