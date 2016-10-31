//
//  CycleModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // MARK: 模型属性
    /// 标题
    var title: String = ""
    /// 图片抵制
    var pic_url: String = ""
    /// 主播信息对应的字典
    var room: [String : Any]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    /// 主播信息对应的模型
    var anchor: AnchorModel?
    
    // MARK: - 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}









