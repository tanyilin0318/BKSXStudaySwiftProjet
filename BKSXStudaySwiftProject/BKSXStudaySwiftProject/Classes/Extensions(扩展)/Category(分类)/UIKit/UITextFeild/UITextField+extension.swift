//
//  UITextField+extension.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit


extension UITextField{
    
    static func initWithMsg(Frame frame:CGRect?, PlaceHolder placeHolder:String?, BackgroundColor backgroundColor:UIColor?, TintColor tintColor:UIColor?,Delegate delegate:Any? ,IsPWD isPwd:Bool) -> UITextField {
        
        let textField = UITextField.init(frame: frame!);
        
        if placeHolder != nil {
            textField.placeholder = placeHolder;
        }
        
        if backgroundColor != nil {
            textField.backgroundColor = backgroundColor;
        }
        
        if tintColor != nil {
            textField.tintColor = tintColor;
        }
        
        if delegate != nil {
            textField.delegate = (delegate as! UITextFieldDelegate);
        }
        
        if isPwd {
            textField.isSecureTextEntry = isPwd;
        }
        
        //other
        textField.clearButtonMode = .always;
        
        
        return textField;
    }
}

class UITextField_extension: NSObject {

}
