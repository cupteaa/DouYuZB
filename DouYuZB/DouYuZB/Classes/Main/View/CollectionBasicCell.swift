//
//  CollectionBasicCell.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class CollectionBasicCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nicknameLable: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    // MARK: - 定义模型属性
    var anchor: AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            // 1.取出在线人数显示的文字
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(onlineStr)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2.设置昵称
            nicknameLable.text = anchor.nickname
            // 3.设置封面图片
            guard let url = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: url)
        }
    }
    
}
