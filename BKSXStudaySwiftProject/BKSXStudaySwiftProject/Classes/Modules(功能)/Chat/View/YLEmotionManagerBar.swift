//
//  YLEmotionManagerBar.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

protocol YLEmotionManagerBarDelegate {
    
    func addButtonClickAction()
    
    func sendButtonClickAcion()
    
    func emotionButtonClickAction()
}

class YLEmotionManagerBar: UIView {
    
    var delegate : YLEmotionManagerBarDelegate?
    
    lazy var addButton: UIButton = {
        let addButton = UIButton.init(type: UIButtonType.custom)
        addButton.backgroundColor = UIColor.white
        addButton.setImage(UIImage(named: "Card_AddIcon"), for: .normal)
        addButton.setImage(UIImage(named: "Card_AddIcon"), for: .highlighted)
        addButton.addTarget(self, action: #selector(barButtonClickAction(_:)), for: .touchUpInside)
        return addButton
    }()
    
    lazy var sendButton: UIButton = {
        let sendButton = UIButton.init(type: .custom)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        sendButton.backgroundColor = UIColor(red:0.13, green:0.41, blue:0.79, alpha:1.00)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitle("发送", for: .highlighted)
        sendButton.addTarget(self, action: #selector(barButtonClickAction(_:)), for: .touchUpInside)
        return sendButton
    }()
    
    lazy var emotionButton: UIButton = {
        let emotionButton = UIButton.init(type: .custom)
        emotionButton.backgroundColor = UIColor.white
        emotionButton.setImage(UIImage(named: "EmotionsEmojiHL"), for: .normal)
        emotionButton.setImage(UIImage(named: "EmotionsEmojiHL"), for: .highlighted)
        emotionButton.addTarget(self, action: #selector(barButtonClickAction(_:)), for: .touchUpInside)
        return emotionButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createView()
    }
    
    fileprivate func createView() -> Void {
        
        self.addSubview(addButton)
        
        self.addSubview(emotionButton)
        
        self.addSubview(sendButton)
        
        
        addButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(45)
        }
        
        emotionButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(addButton.snp.right)
            make.width.equalTo(45)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(53)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func barButtonClickAction(_ sender:UIButton) -> Void {
        
        if sender == addButton {
            if let delegate = delegate{
                delegate.addButtonClickAction()
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
