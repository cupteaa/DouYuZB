//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/11/2.
//  Copyright © 2016年 itcast. All rights reserved.
//  拦截导航控制器的push过程, 隐藏控制器的tabBar

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 获取手势
        guard  let systemGes = interactivePopGestureRecognizer else { return }
        // 2. 获取手势对应的view
        guard let gesView = systemGes.view else { return }
        // 3. 获取系统的target/action
        // 3.1 利用运行时查看所有属性名称
        /*var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }*/
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        // 3.2 取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        // 3.3 取出anction 
        let action = Selector(("handleNavigationTransition:"))
        // 4 创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }


    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
        
    }

}
