//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    // MARK: 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!

    // MARK:定义模型属性
    var cycleModel: CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else { return }
            guard let url = URL(string: cycleModel.pic_url) else { return }
            iconImageView.kf.setImage(with: url)
        }
    }
}
