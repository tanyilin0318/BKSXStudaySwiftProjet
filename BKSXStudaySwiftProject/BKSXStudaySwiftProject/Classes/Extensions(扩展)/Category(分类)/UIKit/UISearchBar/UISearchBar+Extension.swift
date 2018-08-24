//
//  UISearchBar+Extension.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar{
    
    /// 获取 uisearch的取消按钮
    var cancelButton : UIButton{
        get{
            var button = UIButton()
            for view in self.subviews{
                for subView in view.subviews{
                    if subView.isKind(of: UIButton.self){
                        button = subView as! UIButton
                        return button
                    }
                }
            }
            return button
        }
    }
}
