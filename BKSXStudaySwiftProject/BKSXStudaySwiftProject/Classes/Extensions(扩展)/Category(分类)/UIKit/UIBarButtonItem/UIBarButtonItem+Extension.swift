//
//  UIBarButtonItem+Extension.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/24.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /// 便利构造器 图片按钮
    ///
    /// - Parameters:
    ///   - imageName: 图片按钮
    ///   - target: 监听对象
    ///   - actionName: 点击方法
    convenience init(imageName: String , target: AnyObject? ,actionName: String?) {
        
        let button = UIButton(imageName: imageName, backImageName: nil)
        // 判断 actionname
        if let actionName = actionName {
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
            button.isUserInteractionEnabled = true
        } else{
            button.isUserInteractionEnabled = false
        }
        
        self.init(customView: button)
    }
    
    /// 便捷构造器 标题带背景图按钮
    ///
    /// - Parameters:
    ///   - title: 标题名称
    ///   - backImageName: 背景图名称
    ///   - textColor: 标题颜色
    ///   - target: 监听对象
    ///   - actionName: 监听方法
    convenience init(title:String , backImageName:String , textColor:UIColor , target:AnyObject?, actionName:String?) {
        
        let button = UIButton(title: title, fontSize: 16, color: textColor, target: target, actionName: actionName)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        
        if let actionName = actionName {
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
            button.isUserInteractionEnabled = true
        } else{
            button.isUserInteractionEnabled = false
        }
        self.init(customView: button)
    }
    
    /// 便利构造器。 可选择按钮------
    ///
    /// - Parameters:
    ///   - nomalImageName: 扑通图
    ///   - selectedImageName: 选中的图
    ///   - target: 监听
    ///   - actionName: 监听方法
    convenience init(nomalImageName:String ,selectedImageName:String ,target:AnyObject?, actionName:String?) {
        let button = UIButton(imageName: nomalImageName, selectedImageName: selectedImageName, target: target, actionName: actionName)
        
        if let actionName = actionName {
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
            button.isUserInteractionEnabled = true
        } else{
            button.isUserInteractionEnabled = false
        }
        self.init(customView: button)
    }
    
    /// 便利构造器 ---
    ///
    /// - Parameters:
    ///   - title: 标题按钮5
    ///   - textColor: 标题颜色
    ///   - target: 监听
    ///   - actionName: 监听方法
    convenience init(title:String , textColor:UIColor ,target:AnyObject?,actionName:String?) {
        
        let button = UIButton(title: title, fontSize: 16, color: textColor, target: target, actionName: actionName)
        
        // 判断名称
        if let actionName = actionName {
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
            button.isUserInteractionEnabled = true
        }else{
            button.isUserInteractionEnabled = false
        }
        
        self.init(customView: button)
    }
    
    
    
    
}
