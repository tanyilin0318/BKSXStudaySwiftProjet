//
//  UILable+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UILabel{
    
    static func initWithMsg(Text text:String?, Frame frame:CGRect, TextColor textColor:UIColor?, Font font:CGFloat?, TextAligtment textAligtment:NSTextAlignment?) -> UILabel {
        let lable = UILabel.init(frame: frame);
        if text != nil {
            lable.text = text;
        }
        
        if textColor != nil {
            lable.textColor = textColor;
        }
        
        if font != nil {
            lable.font = UIFont.systemFont(ofSize: font!);
        }
        
        if textAligtment != nil {
            lable.textAlignment = textAligtment!;
        }
        
        return lable;
    }
}

class UILable_extension: NSObject {

}
