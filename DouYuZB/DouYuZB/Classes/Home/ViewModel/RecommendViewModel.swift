//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK: - 懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
}
// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData(finishedCallback: @escaping () -> ()) {
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "tiem" : NSDate.getCurrentTime()]
        // 2.创建disGroup
        let dGroup = DispatchGroup()
        // 3.请求第一部分的推荐数据 "最热" 0
        dGroup.enter()
        NetWorkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据data这个key,获取数组,这个数组里存放的是字典
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历字典,并将字典转成模型
            // 3.1 设置组的属性
            self.bigDataGroup.tag_name = "最热"
            self.bigDataGroup.icon_name = "home_header_hot"
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            // 3.3 离开组
            dGroup.leave()
        }
        
        // 4.请求第二部分的数据 "颜值" 1
        dGroup.enter()
        NetWorkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据data这个key,获取数组,这个数组里存放的是字典
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历字典,并将字典转成模型
            // 3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        // 5.请求剩余部分的游戏数据 2~1
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1477837751
//        print(NSDate.getCurrentTime())
        dGroup.enter()
        NetWorkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据data这个key,获取数组,这个数组里存放的是字典
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }

            dGroup.leave()
        }
        // 6.所有数据都请求到,排序
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }
    }
}




















