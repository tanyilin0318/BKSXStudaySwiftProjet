//
//  UIButton+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UIButton{
    
    static func initWithMsg(Type type:UIButton.ButtonType?, Title title:String?, Frame frame:CGRect?, TitleColor titleColor:UIColor?,
                            Image imageName:String?, hImage himageName:String?, BackGroundColor bgColor:UIColor?, Font font:UIFont?, Target target:Any? ,Action action:Selector?) -> UIButton {
        let button = UIButton.init(type: type!);
        
        if title != nil {
            button.setTitle(title, for: .normal);
            button.setTitle(title, for: .highlighted);
        }
        
        if frame != nil {
            button.frame = frame!;
        }
        
        if titleColor != nil {
            button.setTitleColor(titleColor, for: .normal);
            button.setTitleColor(titleColor, for: .highlighted);
        }
        
        if imageName != nil {
            button.setImage(UIImage.init(named: imageName!), for: .normal);
        }
        
        if himageName != nil {
            button.setImage(UIImage.init(named: himageName!), for: .highlighted);
        }
        
        if bgColor != nil {
            button.backgroundColor = bgColor;
        }
        
        if font != nil {
            button.titleLabel?.font = font;
        }
        
        if target != nil && action != nil {
            button.addTarget(target, action: action!, for: .touchUpInside);
        }
        
        return button;
    }
    
    /// 便利构造器 图片和背景图按钮
    ///
    /// - Parameters:
    ///   - imageName: 图像名称
    ///   - backImageName: 背景图名称
    /// return
    /// -备注： 如果名称使用“” 会报错  会抱错误 CUICatalog: Invalid asset name supplied:
    convenience init(imageName: String, backImageName:String?) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        if let backImageName = backImageName {
            setBackgroundImage(UIImage(named: backImageName), for: .normal)
            setBackgroundImage(UIImage(named: backImageName + "highlighted"), for: .highlighted)
        }
        
        sizeToFit()// 根据背景图的大小调整尺寸
    }
    
    
    /// 便利构造器 不同颜色标题按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - color: 标题颜色
    ///   - backImageName: 背景图
    ///   -
    convenience init(title: String , color:UIColor ,backImageName: String) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        setBackgroundImage(UIImage(named: backImageName + "highlighted"), for: .highlighted)
        
        sizeToFit()
    }
    
    /// 便利构造器 背景图
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - fontSize: <#fontSize description#>
    ///   - titleColor: <#titleColor description#>
    ///   - imageName: <#imageName description#>
    ///   - backColor: <#backColor description#>
    convenience init(title :String ,fontSize: CGFloat ,titleColor: UIColor , imageName:String?, backColor:UIColor? = nil) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .highlighted)
        
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
            setImage(UIImage(named: imageName), for: .highlighted)
        }
        
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
    
    /// 便利构造器 标题按钮 带点击方法
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - fontSize: 标题大小
    ///   - color: 标题颜色
    ///   - target: 方法
    ///   - actionName:方法名称
    convenience init(title:String , fontSize:CGFloat , color:UIColor ,target:AnyObject?, actionName:String?) {
        self.init()
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        //判断actionName
        if let actionName = actionName {
            addTarget(target, action: Selector(actionName), for: .touchUpInside)
            isUserInteractionEnabled = true
        }else{
            isUserInteractionEnabled = false
        }
        sizeToFit()
    }
    
    
    /// 便利构造器
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - target: 监听对象
    ///   - actionName: fang fa ming cheng
    convenience init(imageName:String ,target:AnyObject?,actionName:String?) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName), for: .highlighted)
        
        if let actionName = actionName {
            addTarget(target, action: Selector(actionName), for: .touchUpInside)
            isUserInteractionEnabled = true
        } else {
            isUserInteractionEnabled = false
        }
        
        sizeToFit()
    }
    
    
    /// 便利构造器 带选择的
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - selectedImageName: 选择上名称
    ///   - target: 监听对象
    ///   - actionName: 方法名称
    convenience init(imageName:String ,selectedImageName:String ,target:AnyObject?,actionName:String?) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName), for: .selected)
        
        if let actionName = actionName {
            addTarget(target, action: Selector(actionName), for: .touchUpInside)
            isUserInteractionEnabled = true
        } else {
            isUserInteractionEnabled = false
        }
        
        sizeToFit()
    }
    
    
    convenience init(setUpImageAndDownLableWithSpace Space:CGFloat) {
        self.init()
        let imageSize = imageView?.frame.size ?? .zero
        var titleSize = titleLabel?.frame.size ?? .zero
        // 测试的时候发现titleLabel的宽度不正确，这里进行判断处理
        let labelWidth = titleLabel?.intrinsicContentSize.width ?? 0.0
        if (titleSize.width < labelWidth) {
            titleSize.width = labelWidth
        }
        titleEdgeInsets = UIEdgeInsets.init(top: imageSize.height+Space, left: -imageSize.width, bottom: -Space, right: 0.0)
        imageEdgeInsets = UIEdgeInsets.init(top: -Space, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    
}

class UIButton_extension: NSObject {

}
