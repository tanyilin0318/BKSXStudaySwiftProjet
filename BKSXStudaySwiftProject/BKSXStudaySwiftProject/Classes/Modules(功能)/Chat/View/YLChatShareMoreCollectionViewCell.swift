//
//  YLChatShareMoreCollectionViewCell.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/12.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit

class YLChatShareMoreCollectionViewCell: UICollectionViewCell {
    
    var image = UIImage(){
        didSet{
            itemButton.setImage(image, for: .normal)
            itemButton.setImage(image, for: .highlighted)
            
        }
    }
    
    var title : String = ""{
        didSet{
            itemLabel.text = title
        }
    }
    
   fileprivate lazy var itemButton : UIButton! = {
        let itemButton = UIButton(type: UIButtonType.custom)
        itemButton.backgroundColor = UIColor.white //UIColor.withHex(hexString: "eff0f5")
        itemButton.setBackgroundImage(UIImage(named: "sharemore_other_HL"), for: .highlighted)
        itemButton.setBackgroundImage(UIImage(named: "sharemore_other"), for: UIControlState())
        itemButton.layer.cornerRadius = 10
        itemButton.layer.masksToBounds = true
        itemButton.layer.borderColor = UIColor.lightGray.cgColor
        itemButton.layer.borderWidth = 0.5
        return itemButton
    }()
    
    fileprivate lazy var itemLabel: UILabel = {
        let itemLabel = UILabel.initWithMsg(Text: "标题", Frame: .zero, TextColor: UIColor.gray, Font: 11, TextAligtment: .center)
        
        return itemLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    fileprivate func createView() -> Void {
        
        self.contentView.addSubview(itemButton)
        self.contentView.addSubview(itemLabel)
        
        itemButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalTo(itemLabel.snp.top)
            make.width.equalTo(itemButton.snp.height)
            make.centerX.equalToSuperview()
        }
        
        itemLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.bottom.equalToSuperview().offset(-2)
            make.height.equalTo(21)
        }
    }
    
//    override var isHighlighted: Bool{
//        didSet{
//            if isHighlighted {
//                self.itemButton.setBackgroundImage(UIImage(named: "sharemore_other_HL"), for: .highlighted)
//            }else{
//                self.itemButton.setBackgroundImage(UIImage(named: "sharemore_other"), for: UIControlState())
//            }
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
