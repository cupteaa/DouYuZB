//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class AmuseViewModel {
    /// 定义存放模型的数组
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()

}

extension AmuseViewModel {
    func loadAmuseDate(finishedCallback: @escaping () -> ()) {
        NetWorkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            // 1. 将请求到的数据转换成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 取出字典中的数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3. 遍历字典,将字典转成模型
            for dict in dataArray {
                let anchorGroup = AnchorGroup(dict: dict)
                self.anchorGroups.append(anchorGroup)
            }
            // 完成回调
            finishedCallback()
        }
    }
}
