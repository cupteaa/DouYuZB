//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
    }
    
    private func addChildVc(_ storyName: String) {
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
    
}
