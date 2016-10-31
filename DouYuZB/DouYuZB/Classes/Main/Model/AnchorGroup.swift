//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 主播组的模型
class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    var room_list: [[String : Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组图标
//    var icon_url: String = ""
    /// 组显示的图标
    var icon_name: String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()

    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : Any]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }*/
}
