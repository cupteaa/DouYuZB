//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class GameViewModel {
    /// 定义存放模型的数组
    lazy var games: [GameModel] = [GameModel]()

}

// MARK: 发送网络请求
extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        // http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetWorkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 解析数据
            // 1. 将请求到的数据转成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 将字典中的数组取出来key = data
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3. 遍历字典,字典转模型
            for dict in dataArray {
                let game = GameModel(dict: dict)
                self.games.append(game)
            }
            // 4. 完成回调
            finishedCallback()
        }
    }
}
