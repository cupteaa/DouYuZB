//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

fileprivate let kCycleViewH: CGFloat = kScreenW * 3 / 8
fileprivate let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView: RecommandCycleView = {
        let cycleView = RecommandCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView: RecommandGameView = {
        let gameView = RecommandGameView.recommandGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    // MARK: 系统回调函数
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
}

// MARK: - 设置UI
extension RecommendViewController {
    override func setupUI() {
        // 1.调用super
        super.setupUI()
        // 2.将cycleView添加到collectionView中
        collectionView.addSubview(cycleView)
        // 3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        // 4.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
    }
}

// MARK: - 请求数据
extension RecommendViewController {
    override func loadData() {
        // 0.给父类baseVM赋值
        baseVM = recommendVM
        // 1.请求推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            // 2.将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            // 2.1 移除前两个数据
            groups.removeFirst()
            groups.removeFirst()
            // 2.2添加一组"更多"数据
            let more: AnchorGroup = AnchorGroup()
            more.tag_name = "更多"
            groups.append(more)
            self.gameView.groups = groups
            // 3.数据请求完成
            self.loadDataFinished()
        }
        // 2.请求轮播数据
        recommendVM.requestCycleData { 
            // 数据请求完成,将数据传递给cycleView
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}

// MARK: - 遵守数据源协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出prettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    // 返回cell的尺寸    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}




























