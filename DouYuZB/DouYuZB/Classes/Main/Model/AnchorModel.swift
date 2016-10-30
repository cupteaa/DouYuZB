//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间ID
    var room_id: Int = 0
    /// 房间图片的URL
    var vertical_src: String = ""
    /// 手机直播1,电脑直播0
    var isVertical: Int = 0
    /// 房间名称
    var room_name: String = ""
    /// 主播昵称
    var nickname: String = ""
    /// 观看人数
    var online: Int = 0
    /// 所在城市
    var anchor_city: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
