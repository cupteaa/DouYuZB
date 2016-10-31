//
//  GameViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kEdgeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - kEdgeMargin * 2) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    // MARK: 懒加载属性
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
    }()
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -kHeaderViewH - kGameViewH, width: kScreenW, height: kHeaderViewH)
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.titleLabel.text = "常用"
        return topHeaderView
    }()
    fileprivate lazy var gameView: RecommandGameView = {
        let gameView = RecommandGameView.recommandGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

// MARK: - setupUI
extension GameViewController {
    fileprivate func setupUI() {
        // 1.添加collectionView
        view.addSubview(collectionView)
        // 2.将topHeaderView添加到collectionView上
        collectionView.addSubview(topHeaderView)
        // 3.添加gameView
        collectionView.addSubview(gameView)
        // 4.设置collectionView的边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 发送网络请求
extension GameViewController {
    fileprivate func loadData() {
        self.gameVM.loadAllGameData {
            // 展示全部游戏
            self.collectionView.reloadData()
            // 展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

// MARK: - 遵守数据协议
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = self.gameVM.games[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        // 2. 给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}












