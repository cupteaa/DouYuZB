//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/11/2.
//  Copyright © 2016年 itcast. All rights reserved.
//  网络数据加载前的动画显示

import UIKit

class BaseViewController: UIViewController {
    // MARK: 定义属性
    var contentView: UIView?
    // MARK: 懒加载属性
    fileprivate lazy var animImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension BaseViewController {
    func setupUI() {
        // 1. 隐藏contentView
        contentView?.isHidden = true
        // 2. 添加执行动画的UIImageView
        view.addSubview(animImageView)
        // 3. 开始执行动画
        animImageView.startAnimating()
        // 4. 设置背景颜色
        animImageView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    func loadDataFinished() {
        // 1. 停止动画
        animImageView.stopAnimating()
        // 2. 隐藏animImageView
        animImageView.isHidden = true
        // 3. 显示contentView
        contentView?.isHidden = false
    }
}











