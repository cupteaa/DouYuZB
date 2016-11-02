//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50
let kNormalItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH: CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH: CGFloat = kNormalItemW * 4 / 3

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {
    
    // MARK: 定义属性
    var baseVM: BaseViewModel!
    lazy var collectionView: UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        // 设置数据源
        collectionView.dataSource = self
        // 设置代理
        collectionView.delegate = self
        // 注册cell,自定义注册的normalCell--电脑直播
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        // 注册手机直播的cell--pretty
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        // 注册头部view(自定义的头部View)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
        }()

    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }

}

// MARK: - setupUI
extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        // 1. 添加collectionView
        view.addSubview(collectionView)

        super.setupUI()
    }
}

// MARK: - 请求数据
extension BaseAnchorViewController {
    func loadData() {

        }
}

// MARK: - 遵守数据源协议
extension BaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = self.baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = self.baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

// MARK: - 遵守代理协议
extension BaseAnchorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        // 2.判读是电脑直播(普通房间)还是手机直播(秀场房间)
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    private func presentShowRoomVc() {
        let showRoomVc = RoomShowViewController()
        present(showRoomVc, animated: true, completion: nil)
    }
    private func pushNormalRoomVc() {
        let normalRoomVc = RoomNormalViewController()
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}















