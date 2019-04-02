//
//  YLChatEmotionCell.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLChatEmotionCell: UICollectionViewCell {
    
    var isDelete = false
    var emotionModel: EmotionModel? = nil
    
    
    var image = UIImage(){
        didSet{
            imageView.image = image
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        createView()
    }
    
    func createView() -> Void {
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.emotionModel = nil
    }
    
    func setCellContnet(_ modelE:EmotionModel? = nil) -> Void {
        if modelE == nil {
            self.imageView.image = nil
            return
        }
        self.emotionModel = modelE
        self.isDelete = false
        if let path = YLConfig.ExpressionBundle?.path(forResource: modelE?.imageString, ofType: "png") {
            self.image = UIImage(contentsOfFile: path)!
        }
    }
    
    func setDeleteCellContnet() -> Void {
        self.emotionModel = nil
        self.isDelete = true
        self.image = UIImage.init(named: "emotion_delete")!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
