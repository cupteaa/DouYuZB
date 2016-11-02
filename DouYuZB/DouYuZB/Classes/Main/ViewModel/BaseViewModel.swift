//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroup: Bool, URLString: String, parameters: [String : Any]? = nil, finishedCallback:  @escaping () -> ()) {
        NetWorkTools.requestData(.GET, URLString: URLString, parameters: parameters) { (result) in
            // 1. 将请求到的数据转换成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 取出字典中的数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3. 判断是否是分组数据
            if isGroup {
                // 3.1 遍历字典,将字典转成模型
                for dict in dataArray {
                    let anchorGroup = AnchorGroup(dict: dict)
                    self.anchorGroups.append(anchorGroup)
                }
            } else {
                // 2.1 创建组
                let group = AnchorGroup()
                // 2.2 遍历dataArray 将字典转成模型
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                // 2.3 将group添加到anchorGroups中
                self.anchorGroups.append(group)
            }
            
            
            // 完成回调
            finishedCallback()
        }
    }
}




