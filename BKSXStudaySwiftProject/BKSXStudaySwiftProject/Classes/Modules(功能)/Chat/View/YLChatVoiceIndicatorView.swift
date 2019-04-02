//
//  YLChatVoiceIndicatorView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/10.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLChatVoiceIndicatorView: UIView {
    
    /// 背景view
    lazy var centerView: UIView = {
        let centerView = UIView(frame: .zero)
        centerView.layer.cornerRadius = 4.0
        centerView.layer.masksToBounds = true
        centerView.alpha = 0.7
//        centerView.isHidden = true
        centerView.backgroundColor = UIColor.withHex(hexString: "767676")
        return centerView
    }()
    
    /// 底部显示提示lable
    lazy var titleLable: UILabel = {
        let titleLable = UILabel(frame: .zero)
        titleLable.layer.cornerRadius = 2.0
        titleLable.layer.masksToBounds = true
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 14)
        titleLable.textAlignment = .center
        titleLable.backgroundColor = UIColor.clear
//        titleLable.isHidden = true
        return titleLable
    }()
    
    /// 取消提示图片
    lazy var cancelImageView: UIImageView = {
        let cancelImageView = UIImageView(frame: .zero)
        cancelImageView.image = UIImage(named: "RecordCancel")
        cancelImageView.backgroundColor = UIColor.clear
//        cancelImageView.isHidden = true
        return cancelImageView
    }()
    
    /// 整体录音view的背景
    lazy var recordingView: UIView = {
        let recordingView = UIView.init(frame: .zero)
//        recordingView.isHidden = true
        return recordingView
    }()
    
    /// 话筒图
    lazy var recordBkg: UIImageView = {
        let recordBkg = UIImageView.init(image: UIImage(named: "RecordingBkg"))
        recordBkg.backgroundColor = UIColor.clear
        
        return recordBkg
    }()
    
    /// 音量图
    lazy var signalValue: UIImageView = {
        let signalValue = UIImageView(image: UIImage(named: "RecordingSignal001"))
        signalValue.backgroundColor = UIColor.clear
        return signalValue
    }()
    
    /// 录音太短提示图片
    lazy var tooShortPromptImgView: UIImageView = {
        let tooShortPromptImgView = UIImageView(frame: .zero)
        tooShortPromptImgView.image = UIImage(named: "MessageTooShort")
        tooShortPromptImgView.backgroundColor = UIColor.clear
//        tooShortPromptImgView.isHidden = true
        return tooShortPromptImgView
    }()
    
    /// 倒计时显示
    lazy var countDownLab: UILabel = {
        let countDownLab = UILabel(frame: .zero)
        countDownLab.textColor = UIColor.white
        countDownLab.textAlignment = .center
        countDownLab.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight(rawValue: 20))
        countDownLab.text = ""
//        countDownLab.isHidden = true
        countDownLab.backgroundColor = UIColor.clear
        return countDownLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
//        recording()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createView() -> Void {
        self.addSubview(centerView)
        centerView.addSubview(titleLable)
        centerView.addSubview(cancelImageView)
        centerView.addSubview(tooShortPromptImgView)
        centerView.addSubview(recordingView)
        recordingView.addSubview(recordBkg)
        recordingView.addSubview(signalValue)
        centerView.addSubview(countDownLab)
        
        centerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        recordingView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }
        
        recordBkg.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(62)
        }
        
        signalValue.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(38)
        }

        cancelImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }

        tooShortPromptImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }
        
        countDownLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }
    }

}

extension YLChatVoiceIndicatorView{
    /**
        view的各种状态后的显示内容
    */
    
    /// 正在录音 (录音显示 麦克风和音量提示 和字）
    func recording() -> Void {
        self.isHidden = false
        cancelImageView.isHidden = true
        tooShortPromptImgView.isHidden = true
        recordingView.isHidden = false
        countDownLab.isHidden = true
        titleLable.backgroundColor = UIColor.clear
        titleLable.text = "手指上滑，取消发送"
    }
    
    /// 滑动手指到 上滑动取消录音
    func slideToCancelRecord() -> Void {
        self.isHidden = false
        cancelImageView.isHidden = false
        tooShortPromptImgView.isHidden = true
        countDownLab.isHidden = true
        recordingView.isHidden = true
        titleLable.backgroundColor = UIColor.withHex(hexString: "9C3638", alpha: 0.8)
        titleLable.text = "松开手指，取消发送"
    }
    
    /// 录音时间太短 显示
    func recordMsgTooShort() -> Void {
        self.isHidden = false
        cancelImageView.isHidden = true
        tooShortPromptImgView.isHidden = false
        countDownLab.isHidden = true
        recordingView.isHidden = true
        titleLable.backgroundColor = UIColor.clear
        titleLable.text = "说话时间太短"
        
        let delayTime =  DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.endRecord()
        }
        
    }
    

    /// 倒计时
    func recordTooLongCountDown() -> Void {
        self.isHidden = false
        cancelImageView.isHidden = true
        tooShortPromptImgView.isHidden = true
        countDownLab.isHidden = false
        recordingView.isHidden = true
        titleLable.backgroundColor = UIColor.clear
        titleLable.text = "手指上滑，取消发送"
        dispathchTimer(timeInterval: 1, repeatcount: 10) { (timer, count) in
            self.countDownLab.text = "\(count)"
        }
        
        
    }
 
    /// 录音结束
    func endRecord() -> Void {
        self.isHidden = true
    }
    
    ///更新麦克风音量大小导致的图片变化
    func updateMetersValue(_ value: Float) -> Void {
        var index = Int(round(value))
        index = index > 7 ? 7 : index
        index = index < 0 ? 0 : index
        
        let array = ["RecordingSignal001",
                     "RecordingSignal002",
                     "RecordingSignal003",
                     "RecordingSignal004",
                     "RecordingSignal005",
                     "RecordingSignal006",
                     "RecordingSignal007",
                     "RecordingSignal008"]
        
        signalValue.image = getImage(array: array, index: index)
        
    }
    
    
    func getImage(array : Array<Any>, index :Int) -> UIImage {
        let name = array[index]
        return UIImage(named: name as! String)!
    }
    
    func dispathchTimer(timeInterval: Double,repeatcount:Int,handler:@escaping (DispatchSourceTimer?,Int)->()) -> Void {
        if repeatcount <= 0 {
            return
        }
        
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatcount
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler{
            count -= 1
            if count <= 0 {
                timer.cancel()
            }
            DispatchQueue.main.async {
                handler(timer, count)
            }
        }
        timer.resume()
        
    }
    
}
