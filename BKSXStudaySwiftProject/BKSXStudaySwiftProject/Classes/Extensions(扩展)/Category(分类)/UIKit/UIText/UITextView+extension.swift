//
//  UITextView+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UITextView{
    
    static func initWithMsg(Frame frame:CGRect?, backgroundColor:UIColor?, Text text:String?,TextColor textColor:UIColor?, Font font:UIFont?,  Delegate delegate:Any?) -> UITextView {
        
        let textView = UITextView.init(frame: frame!);
        
        if backgroundColor != nil {
            textView.backgroundColor = backgroundColor;
        }

        if text != nil{
            textView.text = text;
        }
        
        if textColor != nil {
            textView.textColor = textColor;
        }
        
        if font != nil {
            textView.font = font;
        }
        
        if delegate != nil {
            textView.delegate = (delegate as! UITextViewDelegate);
        }
        
        //other
        
        return textView;
    }
}

class UITextView_extension: NSObject {

}
