//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 于亚伟 on 2016/10/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK: - 定义协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

// MARK: - 定义PageTitleView类
class PageTitleView: UIView {
    // MARK: - 懒加载属性
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 定义属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    weak var delelgate: PageTitleViewDelegate?
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI
extension PageTitleView {
    fileprivate func setupUI() {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 2.设置scrollView的labels
        setupTitleLabels()
        // 3.设置pageView的底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLabels() {
        // 0.设置label相关的frame参数
        let labelW: CGFloat = kScreenW / CGFloat(titles.count)
        let labelH: CGFloat = frame.size.height - kScrollLineH
        let labelY: CGFloat = 0
        for (index, title) in titles.enumerated() {
            // 1.创建label
            let label = UILabel()
            
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            
            // 3.设置label的frame
            let labelX: CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4.将label加入到scrollView中
            scrollView.addSubview(label)
            // 将标签保存在数组中
            self.titleLabels.append(label)
            // 5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(ges:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    private func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        // 2.添加滚动滑块
        // 2.2.获取第一个label
        guard let firstLabel: UILabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK: - 监听label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(ges: UITapGestureRecognizer) {
        // 1.获取当前点击的label
        guard let currentLabel = ges.view as? UILabel else { return }
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        // 3.修改颜色
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 4.保存最新的label的下标值
        currentIndex = currentLabel.tag
        // 5.修改滚动条的位置
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        // 6.通知代理
        delelgate?.pageTitleView(titleView: self, selectedIndex: currentIndex) 
    }
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    // 同步contentView的滚动与titleView按钮
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 1.取出sourceLabel/targerLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变
        // 3.1.获取颜色渐变的范围
        let delta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        // 3.2.改变sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - progress * delta.0, g: kSelectedColor.1 - progress * delta.1, b: kSelectedColor.2 - progress * delta.2)
        // 3.3.改变targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + progress * delta.0, g: kNormalColor.1 + progress * delta.1, b: kNormalColor.2 + progress * delta.2)
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}






























