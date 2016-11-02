//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView: AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView
    }()
}

// MARK: - 设置UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        // 添加菜单view
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension AmuseViewController {
    override func loadData() {
        // 1. 给父类baseVM赋值
        baseVM = amuseVM
        // 2.请求数据
        amuseVM.loadAmuseDate {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            // 3.数据请求完成
            self.loadDataFinished()
        }
    }
}




















