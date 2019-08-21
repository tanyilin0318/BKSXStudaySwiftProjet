//
//  YLNetworkWarningView.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/6/26.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

protocol  YLNetworkWarningViewDelegate: class{
    //错误状态变化
    func errorChanged(oldValue : YLNetworkWarningView.WarningType, newValue : YLNetworkWarningView.WarningType) -> Void
    //重新加载
    func retryLoad()
}

class YLNetworkWarningView: UIView {
    
    enum WarningType {
        case noError,loading,loadFailed
    }

            //==控件
    let tipLable = UILabel(frame: CGRect.zero)
    let actionButton = UIButton.init(type: .custom)
    let activityIndicator = UIActivityIndicatorView.init(style: .gray)
    fileprivate let buttonSize = CGSize.init(width: 80, height: 30)
    fileprivate let vDistance : CGFloat = 20
    
    weak var delegate : YLNetworkWarningViewDelegate?
    
    var warningType: WarningType = .noError{
        didSet{
            guard oldValue != warningType else {
                return
            }
            switch warningType {
            case .noError:
                setWarning(hiden: true)
                
            case .loading:
                setWarning(hiden: false)
                tipLable.text = "正在加载中..."
                activityIndicator.startAnimating()
                actionButton.isEnabled = false
                setNeedsLayout()
            case .loadFailed:
                setWarning(hiden: false)
                tipLable.text = "数据加载失败"
                activityIndicator.stopAnimating()
                actionButton.isEnabled = true
                setNeedsLayout()
                
            default:
                setWarning(hiden: true)
            }
            
        }
    }
    
    func setWarning(hiden : Bool) -> Void {
        tipLable.isHidden = hiden
        actionButton.isHidden = hiden
        self.isHidden = hiden
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        tipLable.text = "数据加载失败"
        tipLable.textColor = UIColor.black
        tipLable.font = UIFont.systemFont(ofSize: 18)
        
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        actionButton.setTitleColor(tipLable.textColor, for: .normal)
        actionButton.setTitle("重试", for: .normal)
        actionButton.setTitle("", for: .disabled)
        
        actionButton.layer.masksToBounds = true
        actionButton.layer.cornerRadius = 6
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = tipLable.textColor.cgColor
        
        setWarning(hiden: true)
        
        for v in [tipLable ,actionButton ,activityIndicator]{
            addSubview(v)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLable.sizeToFit()
        tipLable.frame.origin = CGPoint(x: max(0, (buttonSize.width - tipLable.frame.width) / 2), y: 0) // 水平居中
        actionButton.frame = CGRect(origin: CGPoint(x: tipLable.center.x - buttonSize.width / 2, y: tipLable.frame.maxY + vDistance), size: buttonSize) // 水平居中
        activityIndicator.center = actionButton.center
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override var intrinsicContentSize: CGSize{
        let size = tipLable.intrinsicContentSize
        return CGSize(width: max(size.width, buttonSize.width), height: size.height + vDistance + buttonSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
