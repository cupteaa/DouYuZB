//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK: 模型属性
    /// 组显示的标题
    var tag_name: String = ""
    var icon_url: String = ""
    
    // MARK: - 构造函数
    override init() {
        
    }
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
