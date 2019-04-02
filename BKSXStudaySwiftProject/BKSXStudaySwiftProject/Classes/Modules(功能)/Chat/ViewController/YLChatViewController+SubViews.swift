//
//  YLChatViewController+SubViews.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/5.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit


private let kCustomKeyBoardHeight = 216.0

extension YLChatViewController{
    /**
     创建各种视图
     */
    func setupSubviews(_ delegate : UITextViewDelegate) -> Void {
        view.addSubview(listTableView)
        setupActionBar(delegate)
        initListTableView()

        setUpKeyBoardInputView()
        setUpVoiceIndicatorView()
    }
    
    fileprivate func initListTableView() -> Void {
        // 点击tableview 隐藏键盘

        listTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(chatActionBarView.snp.top)
        }
    }
    
    /* 初始化栏*/
    fileprivate func setupActionBar(_ delegate:UITextViewDelegate) -> Void {

        chatActionBarView = YLChatActionBarView.init(frame: .zero)
        chatActionBarView.delegate = self
        chatActionBarView.inputTextView.delegate = delegate
        view.addSubview(chatActionBarView)
        chatActionBarView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    /* 初始化 VoiceIndicator*/
    fileprivate func setUpVoiceIndicatorView() -> Void {
        voiceIndicatorView = YLChatVoiceIndicatorView(frame: .zero)
        voiceIndicatorView.isHidden = true
        view.addSubview(voiceIndicatorView)
        voiceIndicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func setUpKeyBoardInputView() -> Void {
        
        emotionInputView = YLChatEmotionInputView.init(frame: .zero)
        view.addSubview(emotionInputView)
        emotionInputView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.left.right.equalToSuperview()
            make.height.equalTo(kCustomKeyBoardHeight)
        }
        
        shareMoreView = YLChatShareMoreView.init(frame: .zero)
        view.addSubview(shareMoreView)
        shareMoreView.snp.makeConstraints { (make) in
            make.bottom.equalTo(chatActionBarView.snp.top )
            make.left.right.equalToSuperview()
            make.height.equalTo(kCustomKeyBoardHeight)
        }
    }
}
