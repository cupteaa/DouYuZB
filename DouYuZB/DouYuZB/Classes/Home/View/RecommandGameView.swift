//
//  RecommandGameView.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"
fileprivate let kEdgeInsetMargin: CGFloat = 10.0

class RecommandGameView: UIView {
    // MARK: 定义数据属性
    var groups: [AnchorGroup]? {
        didSet {
            // 移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            // 添加一组"更多"数据
            let more: AnchorGroup = AnchorGroup()
            more.tag_name = "更多"
            groups?.append(more)
            
            // 监测到有数据传递过来,重新刷新表格
            collectionView.reloadData()
        }
    }
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
    // MARK: 设置layout
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        
//    }

}

// MARK: - 提供一个快速创建view的方法
extension RecommandGameView {
    class func recommandGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}

// MARK: - 遵守数据源协议
extension RecommandGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
    
}








