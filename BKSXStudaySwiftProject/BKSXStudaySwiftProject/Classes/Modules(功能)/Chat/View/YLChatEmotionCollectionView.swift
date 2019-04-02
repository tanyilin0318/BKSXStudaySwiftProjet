//
//  YLChatEmotionCollectionView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit

protocol ChatEmotionCollectionViewDelegate {
    
    /// 点击 cell 或者 删除肩头的点击方法
    ///
    /// - Parameter cell: <#cell description#>
    func emotionCollectionViewDidTapCell(_ cell : YLChatEmotionCell)
}

class YLChatEmotionCollectionView: UICollectionView {
    
    var touchBeganTime:TimeInterval = 0
    var touchMoved = false
    var backSpaceTimer : Timer!
    var currentMagnifierCell: YLChatEmotionCell?

    lazy var magnifierImageView: UIImageView = {//放大镜图
        let magnifierImageView = UIImageView(frame: .zero)
        magnifierImageView.image = UIImage(named: "emoticon_keyboard_magnifier")
        magnifierImageView.isHidden = true
        return magnifierImageView
    }()
    
    lazy var magnifierContentImageView: UIImageView = { //放大镜内容
        let magnifierContentImageView = UIImageView(frame: .zero)
        magnifierContentImageView.centerX = self.magnifierImageView.width / 2.0
        return magnifierContentImageView
    }()
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        isUserInteractionEnabled = true
        canCancelContentTouches = false
        isMultipleTouchEnabled = false
        scrollsToTop = false
        
        createView()
    }
    
    fileprivate func createView() -> Void {
        
        self.magnifierImageView.addSubview(self.magnifierContentImageView)
        
        self.addSubview(self.magnifierImageView)
        magnifierImageView.isHidden = false
        magnifierImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        
    }
    
    /**
        隐藏放大镜
     */
    func hiddenMagnifierImageView() -> Void {
        self.magnifierImageView.isHidden = true
    }
    /**
        显示放大镜
     
        - cell  要显示的cell
     */
    func showMagnifierForCell(_ cell:YLChatEmotionCell) -> Void {
        if cell.isDelete || cell.imageView.image == nil {
            self.hiddenMagnifierImageView()
            return
        }
        
        let rect = cell.convert(cell.bounds, to: self)
        magnifierImageView.center = CGPoint(x: rect.midX, y: magnifierImageView.centerY)
        magnifierImageView.bottom =  rect.maxY - 6
        magnifierImageView.isHidden = false
        
        magnifierContentImageView.image = cell.imageView.image
        
        
        
    }
    
    /**
        根据touch point获取cell
     
     */
    func getCellForTouches(_ touches: Set<UITouch>) -> YLChatEmotionCell {
        let toucn = touches.first
        let point = toucn?.location(in: self)
        let indexPath = self.indexPathForItem(at: point!)
//        if indexPath == nil {
//            return nil
//        }
        let cell = self.cellForItem(at: indexPath!)
        
        return cell as! YLChatEmotionCell
    }
    
    /***/
    
    /***/
    
    /***/
    
    /***/
    
    /***/
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
