//
//  YLChatActionBarView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/5.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit

let kChatActionBarOriginalHeight = 50.0

let kchatActionBarTextViewMaxHeight = 100.0

let kchatActionBarTextViewHeight = kChatActionBarOriginalHeight - 14


let kMargin = 5.0


enum YLChatKeyBoardType:Int {
    case `default`
    case voice
    case text
    case emotion
    case share
}

/**
  表情按钮和分享按钮的键盘位置控制
    */
protocol YLChatActionBarViewDelegate {
    
    /**
        不显示任何自定义键盘，并且回掉中处理frame
        当唤醒自定义键盘的时候。这时候点击切换录音按钮 将要隐藏掉键盘
     */
    func chatActionBarRecordVoiceHiddenKeyBoard()
    
    /*
        显示表情键盘的时候，并处理键盘高度
    */
    func chatActionBarShowEmotionKeyBoard()
    
    /**
        显示分享键盘的时候，并且处理键盘高度
     */
    func chatActionBarShowShareKeyBoard()
    
    /**
        显示键盘 并处理
     */
    func chatActionBarShowCommonKeyBoard()
    
    /**
     
     */
    func recordClick(_ longTap:UILongPressGestureRecognizer)
}

class YLChatActionBarView: UIView {
    
    var keyBoardType:YLChatKeyBoardType = .default
    
    lazy var inputTextViewCurrentHeight = kchatActionBarTextViewMaxHeight
    
    var delegate: YLChatActionBarViewDelegate?
    
    var voiceButton:YLChatButton! = {
        let voiceButton = YLChatButton.init(frame: .zero)
        voiceButton.setImage(UIImage(named: "tool_voice_1"), for: .normal)
        voiceButton.setImage(UIImage(named: "tool_voice_2"), for: .highlighted)
        voiceButton.addTarget(self, action: #selector(voiceButtonClickAction(_:)), for: .touchUpInside)
        return voiceButton
    }()// 声音按钮
    
    var emotionButton:YLChatButton! = {
       let emotionButton = YLChatButton.init(frame: .zero)
        emotionButton.setImage(UIImage(named: "tool_emotion_1"), for: .normal)
        emotionButton.setImage(UIImage(named: "tool_emotion_2"), for: .highlighted)
        emotionButton.addTarget(self, action: #selector(emotionButtonClickAction(_:)), for: .touchUpInside)
        emotionButton.showTypingKeyBoard = false
        return emotionButton
    }()// 表情按钮
    
    var shareButton:YLChatButton! = {
        let shareButton = YLChatButton(frame: .zero)
        shareButton.setImage(UIImage(named: "tool_share_1"), for: .normal)
        shareButton.setImage(UIImage(named: "tool_share_2"), for: .highlighted)
        shareButton.showTypingKeyBoard = false
        shareButton.addTarget(self, action: #selector(shareButtonClickAction(_:)), for: .touchUpInside)
        return shareButton
    }()// 分享按钮
    
    lazy var longTap: UILongPressGestureRecognizer = {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapRecordAction(_:)))
        longTap.minimumPressDuration = 0.1
        return longTap
    }()
    
    /// 按住录音按钮
    var recordButton:YLChatButton! = {
        let recordButton = YLChatButton(frame: .zero)
        recordButton.isHidden = true
        recordButton.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "F3F4F8")), for: .normal)
        recordButton.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "C6C7CB")), for: .highlighted)
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        recordButton.setTitleColor(UIColor.black, for: .normal)
        recordButton.setTitleColor(UIColor.black, for: .highlighted)
        recordButton.layer.borderColor = UIColor.withHex(hexString: "C2C3C7") .cgColor
        recordButton.layer.borderWidth = 0.5
//        recordButton.layer.borderColor = UIColor.gray.cgColor
        recordButton.layer.cornerRadius = 4.0
        recordButton.layer.masksToBounds = true
        recordButton.setTitle("按住 说话", for: .normal)
//        recordButton.setTitle("松开 结束", for: .highlighted)
        
        return recordButton
    }()// 录音按钮
    
    
    /// 输入文本的录入框
    var inputTextView:UITextView! = {
        let inputTextView = UITextView.init(frame: .zero)
        inputTextView.font = UIFont.systemFont(ofSize: 15.0)
        inputTextView.scrollsToTop = false
        inputTextView.layer.borderColor = UIColor.withHex(hexString: "C2C3C7") .cgColor
        inputTextView.layer.borderWidth = 0.5
        inputTextView.layer.cornerRadius = 5.0
        inputTextView.layer.masksToBounds = true
        inputTextView.textContainerInset = UIEdgeInsets(top: 7, left: 5, bottom: 5, right: 5)
        inputTextView.returnKeyType = .send
        inputTextView.enablesReturnKeyAutomatically = true
        inputTextView.layoutManager.allowsNonContiguousLayout = false
//        inputTextView.isHidden = false
        return inputTextView
    }()//文字输入框
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.withHex(hexString: "f2f3f4")
        createView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createView() -> Void {
        
        /// 上边线
        let topBorder = UIView.initWithMsg(Frame: .zero, BackGroundColor: UIColor.withHex(hexString: "C2C3C7"), CornarRadius: 1)
        addSubview(topBorder)
        
        addSubview(voiceButton)
        recordButton.addGestureRecognizer(longTap)
        
        addSubview(recordButton)
        
        addSubview(inputTextView)
        
        addSubview(emotionButton)
        
        addSubview(shareButton)
        
        /// 下边线
        let bottomBorder = UIView.initWithMsg(Frame: .zero, BackGroundColor: UIColor.withHex(hexString: "C2C3C7"), CornarRadius: 1)
        addSubview(bottomBorder)
        
        
        
        /* 位置 */
        
        topBorder.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        voiceButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kMargin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-kMargin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        emotionButton.snp.makeConstraints { (make) in
            make.right.equalTo(shareButton.snp.left).offset(-kMargin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        recordButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(voiceButton.snp.right).offset(kMargin)
            make.right.equalTo(emotionButton.snp.left).offset(-kMargin)
            make.height.equalTo(36)
        }
        
        inputTextView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(voiceButton.snp.right).offset(kMargin)
            make.right.equalTo(emotionButton.snp.left).offset(-kMargin)
            make.height.equalTo(36)
        }
        
        bottomBorder.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

}

extension YLChatActionBarView{
    
    func resetButtonUI() -> Void {
        //
        voiceButton.setImage(UIImage(named: "tool_voice_1"), for: .normal)
        voiceButton.setImage(UIImage(named: "tool_voice_2"), for: .highlighted)
        
        //
        emotionButton.setImage(UIImage(named: "tool_emotion_1"), for: .normal)
        emotionButton.setImage(UIImage(named: "tool_emotion_2"), for: .highlighted)
        
        //
        shareButton.setImage(UIImage(named: "tool_share_1"), for: .normal)
        shareButton.setImage(UIImage(named: "tool_share_2"), for: .highlighted)
    }
    
    /// 当目前是表情或者分享键盘的时候 点击文本唤醒文字输入键盘
    func inputTextViewCallKeyBoard() -> Void {
        self.keyBoardType = .text
        self.inputTextView.isHidden = false
        
        //接下来设置按钮的动作
        recordButton.isHidden = true
        voiceButton.showTypingKeyBoard = false
        emotionButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = false
    }
    
    /// 显示文字输入键盘
    func showCommonKeyBoard() -> Void {
        self.keyBoardType = .text
        self.inputTextView.isHidden = false
        self.inputTextView.becomeFirstResponder()
        
        if let delegate = delegate {
            delegate.chatActionBarShowCommonKeyBoard()
        }
        
        //设置接下来按钮的动作
        recordButton.isHidden = true
        voiceButton.showTypingKeyBoard = false
        emotionButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = false
    }
    
    /// 按语音发送的小圆圈
    func showRecordButton() -> Void {
        self.keyBoardType = .default
        inputTextView.isHidden = true
        inputTextView.resignFirstResponder()
        if let delegate = delegate {
            delegate.chatActionBarRecordVoiceHiddenKeyBoard()
        }
        
        //接下来按钮的动作
        recordButton.isHidden = false
        voiceButton.showTypingKeyBoard = true
        emotionButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = false
    }
    
    /*
     显示表情键盘
     当点击唤起自定义键盘时，操作栏的输入框需要 resignFirstResponder，这时候会给键盘发送通知。
     通知在  TSChatViewController+Keyboard.swift 中需要对 actionbar 进行重置位置计算
     */
    func showEmotionKeybard() -> Void {
        self.keyBoardType = .emotion
        inputTextView.resignFirstResponder()
        inputTextView.isHidden = false
        if let delegate = delegate {
            delegate.chatActionBarShowEmotionKeyBoard()
        }
        
        //设置接下来的按钮的动作
        recordButton.isHidden = true
        emotionButton.showTypingKeyBoard = true
        recordButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = false
    }
    
    /// 显示分享键盘
    func showShareKeyboard() -> Void {
        self.keyBoardType = .share
        inputTextView.resignFirstResponder()
        inputTextView.isHidden = false
        if let delegate = delegate {
            delegate.chatActionBarShowShareKeyBoard()
        }
        
        //设置接下来的动作
        recordButton.isHidden = true
        emotionButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = true
        recordButton.showTypingKeyBoard = false
    }
    
    func resignKeyboard() -> Void {
        self.keyBoardType = .default
        inputTextView.resignFirstResponder()
        
        //设置接下来的按钮
        emotionButton.showTypingKeyBoard = false
        shareButton.showTypingKeyBoard = false
    }
    
    
    /**
     <暂无用到>
     控制切换键盘的时候光标的颜色
     如果是切到 表情或分享 ，就是透明
     如果是输入文字，就是蓝色
     
     - parameter color: 目标颜色
     */
    func changeTextViewCursorColor(_ color: UIColor) -> Void {
        inputTextView.tintColor = color
        UIView.setAnimationsEnabled(false)
        inputTextView.resignFirstResponder()
        inputTextView.becomeFirstResponder()
        UIView.setAnimationsEnabled(true)
    }
}

// MARK: - @extension TSChatViewController.ChatActionBarView action
extension YLChatActionBarView{
    /**
     初始化操作栏的 button 事件。包括 声音按钮，录音按钮，表情按钮，分享按钮 等各种事件的交互
     */
    
    /// 切换声音按钮
    /// --
    /// - Parameter sender: 按钮
    @objc func voiceButtonClickAction(_ sender:YLChatButton) -> Void {
        resetButtonUI() // 重设ui
        // 根据不同状态 切换不同的键盘交互
        let showRecoring = recordButton.isHidden
        if showRecoring {
            // true 录音按钮隐藏 输入框显示中
            showRecordButton() //显示录音按钮
            voiceButton.replaceVoiceButtonUI(showKeyBoard: true)//改变图标为 键盘图标 （）
            
        } else {
            // false 录音按钮显示中。输入框隐藏
            showCommonKeyBoard()//显示录入框和键盘
            voiceButton.replaceVoiceButtonUI(showKeyBoard: false)//。 改变图标为 声音
        }
        
    }
    
    ///录音按钮 添加点击按钮
    @objc func longTapRecordAction(_ tap:UILongPressGestureRecognizer) -> Void {
        if let delegate = delegate {
            delegate.recordClick(tap)
        }
    }
    
    
    /// 切换表情按钮的点击方法
    ///
    /// - Parameter sender: 按钮
    @objc func emotionButtonClickAction(_ sender:YLChatButton) -> Void {
        resetButtonUI() // 重设ui
        //设置button ui。根据 是否显示键盘 来确定表情按钮的图片
        emotionButton.replaceEmotionButtonUI(showKeyboard: !emotionButton.showTypingKeyBoard)
        //根据不同的状态进行不同的键盘交互
        if emotionButton.showTypingKeyBoard {
            //显示键盘
            showCommonKeyBoard()
        } else {
            //显示表情键盘
            showEmotionKeybard()
        }
        
        
    }
    
    
    /// 切换分享键盘
    ///
    /// - Parameter sender: 键盘
    @objc func shareButtonClickAction(_ sender:YLChatButton) -> Void {
        resetButtonUI()// 重设ui
        //分享按钮始终不变，只是改变相应键盘
        if shareButton.showTypingKeyBoard {
            //显示键盘
            showCommonKeyBoard()
        } else {
            //显示分享键盘
            showShareKeyboard()
        }
    }
    
    //文本框的点击，唤醒键盘
    

}


extension YLChatActionBarView:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        resetButtonUI()
        showCommonKeyBoard()
    }
}












