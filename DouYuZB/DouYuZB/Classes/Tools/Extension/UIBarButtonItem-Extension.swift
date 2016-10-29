//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highlightedImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    } */
    // 便利构造函数: 1>convenience开头 2> 在构造函数中必须明确地调用一个设计的构造函数,而且是通过self调用
    convenience init(imageName: String, highlightedImageName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
