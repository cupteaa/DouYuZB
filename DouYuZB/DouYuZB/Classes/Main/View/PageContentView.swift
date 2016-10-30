//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    // MARK: - 定义属性
    fileprivate var childViewControllers: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollViewDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
//        collectionView.bounces = false
        
        // 设置collectionView的数据源
        collectionView.dataSource = self
        // 设置代理
        collectionView.delegate = self
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // 重写构造函数,通过构造函数创建实例对象,同时传递需要的参数
    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        // 1.将所有子控制器添加到父控制器中
        for childVc in childViewControllers {
            parentViewController?.addChildViewController(childVc)
        }
        // 2.添加UICollectionView,用cell来存放子控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 2.设置cell的内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childViewControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollViewDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollViewDelegate {
            return
        }
        // 1.定义需要获取的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 2.判断左滑还是右滑
        let contentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if contentOffsetX > startOffsetX { //左滑
            // 1.计算progress
            progress = (contentOffsetX / scrollViewW) - floor(contentOffsetX / scrollViewW)
            // 2.计算sourceIndex
            sourceIndex = Int(contentOffsetX / scrollViewW)
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count {
                targetIndex = childViewControllers.count - 1
            }
            if contentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{ // 右滑
            // 1.计算progress
            progress = 1 - ((contentOffsetX / scrollViewW) - floor(contentOffsetX / scrollViewW))
            // 2.计算targetIndex
            targetIndex = Int(contentOffsetX / scrollViewW)
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count {
                sourceIndex = childViewControllers.count - 1
            }
        }
        // 3.将progress/sourceIndex/targetIndex传递给pageTitleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - 暴露给外界的方法
extension PageContentView {
    // MARK: 同步titleView的点击与contentView
    func setCurrentIndex(currentIndex: Int) {
        // 禁止代理的flag
        isForbidScrollViewDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}














