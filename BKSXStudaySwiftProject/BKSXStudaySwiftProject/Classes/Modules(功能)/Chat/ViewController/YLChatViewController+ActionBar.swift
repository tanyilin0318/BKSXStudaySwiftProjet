//
//  YLChatViewController+ActionBar.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/7.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit

extension YLChatViewController:YLChatActionBarViewDelegate{
    func chatActionBarShowCommonKeyBoard() {
        
    }
    
    func chatActionBarRecordVoiceHiddenKeyBoard() {
        
    }
    
    func chatActionBarShowEmotionKeyBoard() {
        
    }
    
    func chatActionBarShowShareKeyBoard() {
        
    }
    
    func recordClick(_ longTap: UILongPressGestureRecognizer) {
        if longTap.state == .began {//长按开始
            finishRecording = true
            voiceIndicatorView.recording()//录音图 显示出来
            //开始录音
            chatActionBarView.recordButton.setTitle("松开 结束", for: .normal)
            chatActionBarView.recordButton.replaceRecordButtonUI(isRecord: true)
        }else if(longTap.state == .changed){ // 长按平移
            let point = longTap.location(in: voiceIndicatorView)
            if voiceIndicatorView.point(inside: point, with: nil){
                voiceIndicatorView.slideToCancelRecord()
                finishRecording = false
            }else{
                voiceIndicatorView.recording()
                finishRecording = true
            }
            
        }else if (longTap.state == .ended){
            if finishRecording{
                //停止录音
            }else{
                //暂停录音  
            }
            
            voiceIndicatorView.endRecord()
            chatActionBarView.recordButton.replaceRecordButtonUI(isRecord: false)
            chatActionBarView.recordButton.setTitle("按住 说话", for: .normal)
        }else{
            
        }
    }
    
}

extension YLChatViewController{
    
    /// 控制动作视图高度:
    ///---176/5000当用户想要显示录制键盘时，我们应该将actionBarView的高度设置为原始值。否则我们应该把actionBarView的高度设为当前的高度
    /// - Parameter showExpandable: show or hide expandable inputTextView
     func controlExpandableInputView(showExpandable: Bool) -> Void {
        let textView = chatActionBarView.inputTextView
        let currentTextHeight = chatActionBarView.inputTextViewCurrentHeight
        
        UIView.animate(withDuration: 0.3) {
            let textHeight = showExpandable ? currentTextHeight : kChatActionBarOriginalHeight
            self.chatActionBarView.snp.updateConstraints({ (make) in
                make.height.equalTo(textHeight)
            })
            self.view.layoutIfNeeded()
            self.listTableView.scrollBottomToLastRow()
            textView?.contentOffset = .zero
        }
        
    }
   
    
}
