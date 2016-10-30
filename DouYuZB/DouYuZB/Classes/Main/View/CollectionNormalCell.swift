//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBasicCell {
    // MARK: - 控件属性
    @IBOutlet weak var roomNameLable: UILabel!
    // MARK: - 定义模型属性 
    override var anchor: AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLable.text = anchor?.room_name
        }
    }

}
