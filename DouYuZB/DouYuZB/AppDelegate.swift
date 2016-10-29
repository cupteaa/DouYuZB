//
//  AppDelegate.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 修改tabBarController的四个按钮的颜色
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }



}

