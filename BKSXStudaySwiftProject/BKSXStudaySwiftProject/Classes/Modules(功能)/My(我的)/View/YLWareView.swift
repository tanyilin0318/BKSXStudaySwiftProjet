//
//  YLWareView.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/12/10.
//  Copyright © 2018 Bksx-cp. All rights reserved.
//

import UIKit

class YLWareView: UIView {
    
    
    /// 波浪曲度
    var wareCurvature:CGFloat?
    /// 波浪速度
    var wareSpeed:CGFloat?
    /// 波浪高度
//    var wareHeight:CGFloat?
    
    var wareHeight: CGFloat!
    /// 真实波浪颜色
    var realWareColor:UIColor?
    /// 遮罩波浪颜色
    var maskWareColor:UIColor?
    /// <#Description#>
    var imageFrame:CGRect?
//    let waveBlock:(CGRect)->Void?
    var offset : CGFloat!
    
    /// 定时器
    fileprivate var timer:CADisplayLink?
    /// 真实波浪动画
    fileprivate var realWareLayer: CAShapeLayer!
    /// 遮罩波浪动画
    fileprivate var maskWareLayer:CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        wareSpeed = 0.5
        wareCurvature = 1.5
        self.wareHeight = 4
        realWareColor = UIColor.white
        maskWareColor = UIColor.init(white: 1, alpha: 0.4)
        
        
        createView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() -> Void {
        realWareLayer = CAShapeLayer(layer: layer)
        var frame = bounds
        frame.origin.y = frame.size.height - self.wareHeight
        frame.size.height = self.wareHeight
        realWareLayer.frame = frame
        realWareLayer.fillColor = self.realWareColor?.cgColor
        
        maskWareLayer = CAShapeLayer(layer: layer)
        var frameM = bounds
        frameM.origin.y = frameM.size.height - self.wareHeight
        frameM.size.height = self.wareHeight
        maskWareLayer.frame = frameM
        maskWareLayer.fillColor = self.maskWareColor?.cgColor
        
        self.layer.addSublayer(realWareLayer)
        self.layer.addSublayer(maskWareLayer)
    }
    
    func setWareHeight(height:CGFloat){
        self.wareHeight = height
        var frame = bounds
        frame.origin.y = frame.size.height - self.wareHeight
        frame.size.height = self.wareHeight
        realWareLayer.frame = frame
        maskWareLayer.frame = frame
    }

    @objc func ware()-> Void{
        
        self.offset += self.wareHeight
        
        var width = self.frame.width
        var height = self.wareHeight
        
        var realPath = CGMutablePath.init()
        
    }
}


extension YLWareView{
    
    func stopWareAnimation() -> Void {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func startWareAnimation() -> Void {
        timer = CADisplayLink(target: self, selector: #selector(ware))
//        self.timer?.add(to: RunLoop.current, forMode: .RunLoop.Mode.common)
        self.timer?.add(to: RunLoop.current, forMode: .common)
    }
}
