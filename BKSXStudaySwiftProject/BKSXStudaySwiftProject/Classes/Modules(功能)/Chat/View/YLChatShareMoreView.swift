//
//  YLChatShareMoreView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/12.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit

private let KleftRightPadding = 15.0
private let kTopBottomPadding = 10.0
private let kItemCountOfRow = 4

protocol ChatShareMoreViewDelegate {
    
    /**
     选择相册
     */
    func chatShareMoreViewPhotoTaped()
    
    
    /**
     选择相机
     */
    func chatShareMoreViewCameraTaped()
}


class YLChatShareMoreView: UIView {
    
    lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.backgroundColor = UIColor.withHex(hexString: "f2f3f4")
        pageControl.currentPage = 0
        pageControl.numberOfPages = titleArray.count/8 + (titleArray.count % 8 == 0 ? 0 : 1)
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        return pageControl
    }()
    
//    lazy var collectionLayout: YLFullyHorizontalFlowLayout = {
//        let collectionLayout = YLFullyHorizontalFlowLayout.init()
//        collectionLayout.minimumLineSpacing = 15
//        collectionLayout.minimumInteritemSpacing = 0
//        collectionLayout.sectionInset = UIEdgeInsetsMake(CGFloat(kTopBottomPadding), CGFloat(KleftRightPadding), CGFloat(kTopBottomPadding), CGFloat(KleftRightPadding))
//        let itemSizeW = (CGFloat(SCREEN_WIDTH) - 90)/4.0
//        let itemSizeH = CGFloat(80)
//        collectionLayout.itemSize = CGSize(width: itemSizeW, height: itemSizeH)
//        return collectionLayout
//    }()
    lazy var collectionLayout: YLChatHorizontalLayout = {
         let collectionLayout = YLChatHorizontalLayout.init(column: 4, row: 2)
        return collectionLayout
    }()
    
    lazy var listCollectionView: UICollectionView = {
        let listCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: collectionLayout)
        listCollectionView.backgroundColor = UIColor.clear
        listCollectionView.register(YLChatShareMoreCollectionViewCell.self, forCellWithReuseIdentifier: "shareCell")
        listCollectionView.showsHorizontalScrollIndicator = false
        listCollectionView.isPagingEnabled = true
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        return listCollectionView
    }()
    
    var delegate : ChatShareMoreViewDelegate?
    
    fileprivate let titleArray = ["照片","拍摄","小视频","语音通话","红包","转账","位置","收藏","个人名片","语音输入","卡卷"]
    fileprivate let imageArray = ["sharemore_pic","sharemore_video","sharemore_sight","sharemore_videovoip","sharemore_wallet","sharemorePay","sharemore_location","sharemore_myfav","sharemore_friendcard","sharemore_voiceinput","sharemore_wallet"]
    fileprivate var groupDataSouce = [[(name : String , iconImage:UIImage)]]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        self.backgroundColor = UIColor.withHex(hexString: "eff0f5")
    }
    
    func createView() -> Void {
        
        
        self.addSubview(pageControl)
        self.addSubview(listCollectionView)
        
        listCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(197)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(37)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YLChatShareMoreView : UICollectionViewDelegateFlowLayout{
    
}

extension YLChatShareMoreView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension YLChatShareMoreView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shareCell", for: indexPath) as! YLChatShareMoreCollectionViewCell
            cell.image = UIImage(named: imageArray[indexPath.row])!
            cell.title = titleArray[indexPath.row]
        
        return cell
    }
    

    
}

extension YLChatShareMoreView : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.listCollectionView.width
        self.pageControl.currentPage = Int(listCollectionView.origin.x/pageWidth)

    }
    
}
