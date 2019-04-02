//
//  YLProgressHUD.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/19.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SVProgressHUD

fileprivate enum HUDType:Int {
    case success
    case errorObject
    case errorString
    case info
    case loading
    
}

class YLProgressHUD: NSObject {

    class func yl_initHUD() -> Void {
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14))
        SVProgressHUD.setDefaultMaskType(.none)
    }
    
    /// 成功
    ///
    /// - Parameter string: 提示语
    class func yl_showSuccessWithStatus(_ string:String) -> Void {
        self.YLProgressHUDShow(.success, status: string, error: nil)
    }
    
    /// 失败
    ///
    /// - Parameter error: nserror
    class func yl_showErrorWithObject(_ error:NSError) -> Void {
        self.YLProgressHUDShow(.errorObject, status: nil, error: error)
    }
    
    /// 失败
    ///
    /// - Parameter string: string
    class func yl_showErrorWithStatus(_ string:String) -> Void {
        self.YLProgressHUDShow(.errorString, status: string, error: nil)
    }
    
    /// 转菊花
    ///
    /// - Parameter string: 字符串
    class func yl_showWithStatus(_ string:String) -> Void {
        self.YLProgressHUDShow(.loading, status: string, error: nil)
    }
    
    /// 警告
    ///
    /// - Parameter string: 字符串
    class func yl_showWarningWithStatus(_ string:String){
        self.YLProgressHUDShow(.info, status: string, error: nil)
    }
    
    /// dismiss 全部消失
    class func yl_dissmis(){
        SVProgressHUD.dismiss()
    }
    
    //私有方法
    fileprivate class func YLProgressHUDShow(_ type:HUDType,status:String?=nil , error:NSError? = nil) -> Void {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
            break
        case .errorObject:
            guard let newError = error else{
                SVProgressHUD.showError(withStatus: "Error:出错了")
                return
            }
            
            if newError.localizedFailureReason == nil{
                SVProgressHUD.showError(withStatus: "Error:出错了")
            }else{
                SVProgressHUD.showError(withStatus: error?.localizedFailureReason)
            }
            break
        case .errorString:
            SVProgressHUD.showError(withStatus: status)
            break
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
            break
        case .loading:
            SVProgressHUD.show(withStatus: status)
            break
        }
    }
}
