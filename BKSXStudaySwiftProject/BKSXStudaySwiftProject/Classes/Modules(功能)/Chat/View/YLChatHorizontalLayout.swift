//
//  YLChatHorizontalLayout.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/21.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLChatHorizontalLayout: UICollectionViewFlowLayout {
    
    // 保存所有的item
    fileprivate var attributesArr : [UICollectionViewLayoutAttributes] = []
    fileprivate var column = 0
    fileprivate var row = 0
    
    
    init(column:Int , row: Int) {
        super.init()
        self.column = column
        self.row = row
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///   这里做一些初始化
    override func prepare() {
        super.prepare()

        let itemWH = UIScreen.main.bounds.size.width / CGFloat(column)
        
//        设置itemSize
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        scrollDirection = .horizontal
        
        //设置collection
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        /// 上下的间距 高度 - 去空间的高度
        let insetMargin = ((collectionView?.bounds.height)! - CGFloat(row)*itemWH) * 0.5
        collectionView?.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0)
        var page = 0
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0..<itemCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            page = itemIndex / (column * row)
            // 通过一系列结算 得到x y
            let x = itemSize.width * CGFloat(itemIndex % Int(column)) + (CGFloat(page) * UIScreen.main.bounds.width)
            let y = itemSize.height * CGFloat((itemIndex - page * row * column) / column)
            
            attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            //把每一个新的属性保存起来
            attributesArr.append(attributes)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var rectAttributes : [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame){
                rectAttributes.append($0)
            }
        })
        
        return rectAttributes
        
    }

    
    
}
