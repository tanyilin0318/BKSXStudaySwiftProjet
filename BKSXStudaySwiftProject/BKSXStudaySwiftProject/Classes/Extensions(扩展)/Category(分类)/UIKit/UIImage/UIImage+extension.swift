//
//  UIImage+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UIImage{
    /// 生成纯色图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 图片纯色
    func imageWithColor(color : UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}

class UIImage_extension: NSObject {

}
