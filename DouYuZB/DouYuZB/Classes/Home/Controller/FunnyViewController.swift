//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/11/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

private let kMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    // MARK: 懒加载
    fileprivate let funnyVM: FunnyViewModel = FunnyViewModel()
    
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: kMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        // 1. 给父类的vm赋值
        baseVM = funnyVM
        // 2. 刷新数据
        funnyVM.loadData {
            self.collectionView.reloadData()
            // 3.数据请求完成
            self.loadDataFinished()
        }
    }
}
