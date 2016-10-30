//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBasicCell {
    // MARK: - 控件属性
    @IBOutlet weak var cityLable: UIButton!
    
    
    
    // MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            // 1.将模型传递给父类
            super.anchor = anchor
            // 2.设置城市
            cityLable.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
