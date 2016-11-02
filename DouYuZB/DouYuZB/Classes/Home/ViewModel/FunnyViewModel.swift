//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/11/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroup: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
