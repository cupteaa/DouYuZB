//
//  RecommandCycleView.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kCycleCellID = "kCycleCellID"

class RecommandCycleView: UIView {
    
    // MARK: 定义属性
    var cycleTimer: Timer?
    
    var cycleModels: [CycleModel]? {
        didSet {
            // 1.刷新表格
            collectionView.reloadData()
            // 2.设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            // 3.默认滚到中间某个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }

    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: 系统回调函数
    override func awakeFromNib() {
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        // 注册自定义的cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    // MARK: 设置layout
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }

}

// MARK: - 提供一个快速创建view的方法
extension RecommandCycleView {
    class func recommendCycleView() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}

// MARK: - 遵守数据源协议
extension RecommandCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

// MARK: - 遵守代理协议 
extension RecommandCycleView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 删除定时器
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 添加定时器
        addCycleTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.取出偏移量
        let offsetX = scrollView.contentOffset.x + kScreenW * 0.5
        // 2.设置pageControll当前页
        pageControl.currentPage = Int(offsetX / kScreenW) % (cycleModels!.count)
    }
    
}

// MARK: - 对定时器的操作
extension RecommandCycleView {
    // MARK: 添加定时器
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    // MARK: 删除定时器
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}














