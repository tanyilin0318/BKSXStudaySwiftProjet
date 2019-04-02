//
//  UIView+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/12.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

public enum ShakeDirection: Int
{
    case horizontal
    case vertical
}


extension UIView {
    
    /// x
    var x : CGFloat{
        get {
            return frame.origin.x;
        }
        
        set (newValue) {
            var tempFrame : CGRect = frame;
            tempFrame.origin.x = newValue;
            frame = tempFrame;
        }
    }
    
    /// y
    var y : CGFloat{
        get {
            return frame.origin.y;
        }
        
        set (newValue) {
            var tempFrame : CGRect = frame;
            tempFrame.origin.y = newValue;
            frame = tempFrame;
        }
    }
    
    /// right
    var right : CGFloat{
        get{
            return frame.origin.x + frame.size.width
        }
        
        set(newValue){
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newValue - tempFrame.size.width
            frame = tempFrame
        }
    }
    
    /// bottom
    var bottom : CGFloat{
        get{
            return frame.origin.y + frame.size.height
        }
        
        set(newValue){
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newValue - tempFrame.size.height
            frame = tempFrame
        }
    }
    
    
    
    /// width
    var width : CGFloat {
        get {
            return frame.size.width;
        }
        
        set (newValue) {
            var tempFrame : CGRect = frame;
            tempFrame.size.width = newValue;
            frame = tempFrame;
        }
    }
    
    /// height
    var height : CGFloat {
        get {
            return frame.size.height;
        }
        
        set (newValue) {
            var tempFrame : CGRect = frame;
            tempFrame.size.height = newValue;
            frame = tempFrame;
        }
    }
    
    /// size
    var size : CGSize {
        get {
            return frame.size;
        }
        
        set (newValue) {
            var tempValue : CGRect = frame;
            tempValue.size = newValue;
            frame = tempValue;
        }
    }
    
    /// origin
    var origin  : CGPoint {
        get {
            return frame.origin;
        }
        
        set (newValue) {
            var tempValue : CGRect = frame;
            tempValue.origin = newValue;
            frame = tempValue;
        }
    }
    
    /// centerX
    var centerX : CGFloat{
        get {
            return center.x;
        }
        
        set (newValue) {
            var tempCenter : CGPoint = center;
            tempCenter.x = newValue;
            center = tempCenter;
        }
    }
    
    /// centerY
    var centerY : CGFloat{
        get {
            return center.y;
        }
        
        set (newValue) {
            var tempCenter : CGPoint = center;
            tempCenter.y = newValue;
            center = tempCenter;
        }
    }
    
    static func initWithMsg(Frame frame:CGRect?, BackGroundColor bgColor:UIColor?, CornarRadius radius:CGFloat?) -> UIView {
        let view = UIView.init(frame: frame!);
        
        if bgColor != nil {
            view.backgroundColor = bgColor;
        }
        
        if radius != nil {
            view.layer.cornerRadius = radius!;
        }
        
        return view;
    }
    
    // MARK: - 扩展UIView,增加抖动方法
    ///
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认5次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认2）
    ///   - completion: 抖动动画结束后的回调
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5, interval: TimeInterval = 0.1, delta: CGFloat = 2, completion: (() -> Void)? = nil)
    {
        UIView.animate(withDuration: interval, animations: {
            
            switch direction
            {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
            }
        }) { (finish) in
            
            if times == 0
            {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (finish) in
                    completion?()
                })
            }
            else
            {
                self.shake(direction: direction, times: times - 1, interval: interval, delta: -delta, completion: completion)
            }
        }
    }
}

class UIView_extension: UIView {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
