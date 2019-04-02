//
//  YLChatButton.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/6.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLChatButton: UIButton {
    
    
    var showTypingKeyBoard:Bool
    
    override init(frame: CGRect) {
        showTypingKeyBoard = true
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 控制--切换语音录入和键盘切换的图标变化( 控制声音按钮的显示图标 )
    ///
    /// - Parameter showKeyBoard: bool
    func replaceVoiceButtonUI(showKeyBoard:Bool) -> Void {
        if showKeyBoard {
            setImage(UIImage(named: "tool_keyboard_1"), for: UIControlState())
            setImage(UIImage(named: "tool_keyboard_2"), for: .highlighted)

        } else {
            setImage(UIImage(named: "tool_voice_1"), for: UIControlState())
            setImage(UIImage(named: "tool_voice_2"), for: .highlighted)
        }
    }
    
    /// 控制-- 切换表情按钮和键盘的图标变化
    ///
    /// - Parameter shwoKeyboard: bool
    func replaceEmotionButtonUI(showKeyboard : Bool) -> Void {
        if showKeyboard {
            setImage(UIImage(named: "tool_keyboard_1"), for: UIControlState())
            setImage(UIImage(named: "tool_keyboard_2"), for: .highlighted)
        } else {
            setImage(UIImage(named: "tool_emotion_1"), for: UIControlState())
            setImage(UIImage(named: "Tool_emotion_2"), for: .highlighted)
        }
    }
    
    func replaceRecordButtonUI(isRecord: Bool) -> Void {
        if isRecord {
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "C6C7CB")), for: .normal)
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "F3F4F8")), for: .highlighted)
        } else {
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "F3F4F8")), for: .normal)
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.withHex(hexString: "C6C7CB")), for: .highlighted)
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
