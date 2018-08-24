//
//  UIViewController+Extension.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    fileprivate func YL_pushViewController(_ viewController:UIViewController ,animated:Bool, hidenTabbar:Bool){
        viewController.hidesBottomBarWhenPushed = hidenTabbar
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    /// push
    ///
    /// - Parameter viewController: 视图控制器
    public func YL_pushAndHidenTabbar(_ viewController:UIViewController){
        self.YL_pushViewController(viewController, animated: true, hidenTabbar: true)
    }
    
    /// 弹出视图
    ///
    /// - Parameters:
    ///   - viewController: 视图
    ///   - completion: 拦截方法
    public func YL_presentViewController(_ viewController:UIViewController, completion:(()->Void)?){
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: completion)
        
    }
    
    /// 返回按钮不显示任何文字
    func hideBackBarButtionTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func createCustomBackButton() {
        let iconPointSize:CGFloat = 20
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onPopButton), for: .touchUpInside)
        button.setImage(UIImage(named: ""), for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 15)
        button.sizeToFit()
        button.center = CGPoint(x: 15 + iconPointSize/2.0 , y: 20+21)// 状态栏 + 导航栏 = 20 + 44，按系统导航栏惯例是导航栏中心往上偏移1point
        view.addSubview(button)
    }
    
    @objc func onPopButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func onDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

























