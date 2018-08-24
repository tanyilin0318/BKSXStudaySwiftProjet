//
//  UIImageView+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/12.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 设置图片圆角
    func circle() {
        /// 建立上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
        /// 获取当前上下文
        let ctx = UIGraphicsGetCurrentContext();
        ///添加一个圆 并剪彩
        ctx?.addEllipse(in: self.bounds);
        ///剪裁
        ctx?.clip();
        ///绘制图像
        self.draw(self.bounds);
        /// 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext();
        ///关闭上下文
        UIGraphicsEndImageContext();
        DispatchQueue.global().async {
            self.image = image;
        }
        
    }
    
    
    static func initWithMsg(Frame frame:CGRect?, Image imageName:String?,BackGroundColor BGColor:UIColor?, CornarRadius radius:CGFloat?) -> UIImageView {
        let imageView = UIImageView.init();
        if frame != nil {
            imageView.frame = frame!;
        }
        
        if imageName != nil {
            imageView.image = UIImage.init(named: imageName!);
        }
        
        if BGColor != nil {
            imageView.backgroundColor = BGColor!;
        }
        
        if radius != nil {
            imageView.layer.cornerRadius = radius!;
        }
        
        return imageView;
    }
}

class UIImageView_extension: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
