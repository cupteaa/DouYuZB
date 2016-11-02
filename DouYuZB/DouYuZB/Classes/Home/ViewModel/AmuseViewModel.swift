//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}

extension AmuseViewModel {
    func loadAmuseDate(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroup: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
