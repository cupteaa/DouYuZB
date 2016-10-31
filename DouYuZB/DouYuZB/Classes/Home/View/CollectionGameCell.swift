//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    // MARK: 定义模型属性
    var group: AnchorGroup? {
        didSet {
            nameLabel.text = group?.tag_name
            guard let group = group else { return }
            
            if let url = URL(string: group.icon_url) {
                iconImageView.kf.setImage(with: url)
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
}
