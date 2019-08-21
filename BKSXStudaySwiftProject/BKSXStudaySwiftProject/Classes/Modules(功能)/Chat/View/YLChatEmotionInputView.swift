//
//  YLChatEmotionInputView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit
import Dollar

private let itemHeight : CGFloat = 50
private let kOneGroupCount = 23
private let kNumberOfOneRow : CGFloat = 8
private let kEmotionViewHeight:CGFloat = 160.0

/**
 *  表情键盘的代理方法
 */
// MARK: - @delegate ChatEmotionInputViewDelegate
protocol ChatEmotionInputViewDelegate {
    
    func didSelectorItemEmotionCell(_ cell : EmotionModel)
    
    func didSelectorItemDelCell()
}

class YLChatEmotionInputView: UIView {
    
    let cellID = "emotionCell"
    
    /// 表情布局
    lazy var flowLayOut: UICollectionViewFlowLayout = {
        let flowLayOut = UICollectionViewFlowLayout.init()
//         let flowLayOut = YLChatHorizontalLayout.init(column: 2, row: 8)
        return flowLayOut
    }()
    
    /// 表情列表 collectionView
    lazy var listCollectionView: YLChatEmotionCollectionView = {
        let listCollectionView = YLChatEmotionCollectionView.init(frame: .zero, collectionViewLayout: flowLayOut)
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.register(YLChatEmotionCell.self, forCellWithReuseIdentifier: cellID)
        listCollectionView.backgroundColor = UIColor.withHex(hexString: "f2f3f4")
        listCollectionView.isPagingEnabled = true
        return listCollectionView
    }()
    
    /// 页码
    lazy var enmotionPageControl: UIPageControl = {
        let emotionPageControl = UIPageControl.init(frame: .zero)
        emotionPageControl.backgroundColor = UIColor.withHex(hexString: "f2f3f4")
        emotionPageControl.pageIndicatorTintColor = UIColor.white
        emotionPageControl.currentPageIndicatorTintColor = UIColor.gray
        return emotionPageControl
    }()
    
    /// 底部表情管理bar
    lazy var emotionBar: YLEmotionManagerBar = {
        let emotionBar = YLEmotionManagerBar.init(frame: .zero)
//        emotionBar.backgroundColor = UIColor.blue
        return emotionBar
    }()
    
    /// 表情包数组 包含小数组（表情组）
    var groupDataSouce = [[EmotionModel]]()
    /// 表情数组
    var emotionDataSouce = [EmotionModel]()
    var delegate : ChatEmotionInputViewDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func createView() -> Void {
        
        let itemWidth = (SCREEN_WIDTH - 10*2)/kNumberOfOneRow
        let padding = (SCREEN_WIDTH - kNumberOfOneRow * itemWidth)/2.0
        let paddingLeft = padding
        let paddingRight = SCREEN_WIDTH - paddingLeft - itemWidth*kNumberOfOneRow
        
        // init flowlayout
        flowLayOut.scrollDirection = .horizontal
        flowLayOut.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        flowLayOut.minimumLineSpacing = 0
        flowLayOut.minimumInteritemSpacing = 0
        flowLayOut.sectionInset = UIEdgeInsets.init(top: 10, left: paddingLeft, bottom: 0, right: paddingRight)
        
        /// init dataSource
        guard let emojiArray = NSArray.init(contentsOfFile: YLConfig.ExpressionPlist!) else {
            return
        }
        
        for data in emojiArray {
            let model = EmotionModel.init(fromDictionary: data as! NSDictionary)
            self.emotionDataSouce.append(model)
        }
        
        self.groupDataSouce = Dollar.chunk(self.emotionDataSouce, size: 23) //数组切割 23为一组
        
        self.listCollectionView.reloadData()
        
        self.enmotionPageControl.numberOfPages = self.groupDataSouce.count
        
        addSubview(listCollectionView)
        
        addSubview(enmotionPageControl)
        
        addSubview(emotionBar)
        
        listCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(160)
        }
        
        enmotionPageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(emotionBar.snp.top)
            make.top.equalTo(listCollectionView.snp.bottom).offset(-6)
        }
        
        emotionBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(38)
        }
    }
    
    func emotionForIndexPath(_ indexPath:IndexPath) -> EmotionModel?{
        let page = indexPath.section
        var index = page * kOneGroupCount + indexPath.row
        
        let ip = index / kOneGroupCount //重新计算所在page
        let ii = index % kOneGroupCount //重新计算所在 index
        let reIndex = (ii % 3) * Int(kNumberOfOneRow) + (ii/3) //最终显示在数据源的
        
        index = reIndex + ip * kOneGroupCount
        if index < self.emotionDataSouce.count {
            return self.emotionDataSouce[index]
        }else{
            return nil
        }
    }

}

extension YLChatEmotionInputView:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.groupDataSouce.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kOneGroupCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! YLChatEmotionCell
        if indexPath.row == kOneGroupCount {
            cell.setDeleteCellContnet()
        }else{
            cell.setCellContnet(self.emotionForIndexPath(indexPath))
        }
        return cell
    }
    
    
    
}

extension YLChatEmotionInputView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if indexPath.row == kOneGroupCount {
            if let delegate = delegate{
                delegate.didSelectorItemDelCell()
            }
        }else{
            let model = self.emotionForIndexPath(indexPath)
            if let delegate = delegate{
                delegate.didSelectorItemEmotionCell(model!)
            }
        }
    }
    
}


extension YLChatEmotionInputView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.listCollectionView.width
        self.enmotionPageControl.currentPage = Int(self.listCollectionView.contentOffset.x / pageWidth)
    }
}



















