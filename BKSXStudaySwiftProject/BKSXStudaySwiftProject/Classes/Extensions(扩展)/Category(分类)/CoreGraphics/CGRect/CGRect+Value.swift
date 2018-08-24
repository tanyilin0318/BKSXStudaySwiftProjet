//
//  CGRect+Value.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/11.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension CGRect{
    
    /// 屏幕适配
    ///
    /// - Parameters:
    ///   - YL_x: x
    ///   - YL_y: y
    ///   - YL_width: w
    ///   - YL_height: h
    init(YL_x:Float ,YL_y:Float ,YL_width:Float ,YL_height:Float ) {
        self.init();
 
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        origin.x = CGFloat(appDelegate.autoSizeScaleX * YL_x);
        origin.y = CGFloat(appDelegate.autoSizeScaleX * YL_y);
        size.width = CGFloat(appDelegate.autoSizeScaleX * YL_width);
        size.height = CGFloat(appDelegate.autoSizeScaleX * YL_height);
    }
    
    /// 屏幕适配 高度不变
    ///
    /// - Parameters:
    ///   - YL_x: x
    ///   - YL_y: y
    ///   - YL_width: w
    ///   - height: h
    init(YL_x:Float ,YL_y:Float ,YL_width:Float ,height:Float ) {
        self.init();
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        origin.x = CGFloat(appDelegate.autoSizeScaleX * YL_x);
        origin.y = CGFloat(appDelegate.autoSizeScaleX * YL_y);
        size.width = CGFloat(appDelegate.autoSizeScaleX * YL_width);
        size.height = CGFloat(height);
    }
    
    /// 屏幕适配   宽度不变
    ///
    /// - Parameters:
    ///   - YL_x: x
    ///   - YL_y: y
    ///   - width: w
    ///   - YL_height: h
    init(YL_x:Float ,YL_y:Float ,width:Float ,YL_height:Float ) {
        self.init();
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        origin.x = CGFloat(appDelegate.autoSizeScaleX * YL_x);
        origin.y = CGFloat(appDelegate.autoSizeScaleX * YL_y);
        size.width = CGFloat(width);
        size.height = CGFloat(appDelegate.autoSizeScaleX * YL_height);
    }
    
}

class CGRect_Value: NSObject {

}
