//
//  AboutAppMsg.swift
//  MessageChat
//
//  Created by 谭林杰 on 2018/7/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

public struct App{
    
    /// app名称
    public static var appName: String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    /// app发布版本号
    public static var appVersion: String{
        return  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// app内部标示版本号
    public static var appBuild: String{
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey! as String) as!String
    }
    
    /// 唯一标示
    public static var bundleIdentifier: String{
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /// 项目名称
    public static var bundleName: String{
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    /// appstore下载地址
    public static var appStoreURL:URL{
        return URL(string: "dddd")!
    }
    
    /// 版本和构建号
    public static var appVersionAndBuild:String {
        let version = appVersion
        let build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    /// 广告标示符，适用于对外：例如广告推广，换量等跨应用的用户追踪等。
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    /// Vindor标示符，适用于对内：例如分析用户在应用内的行为等。
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    /// 设备方向方向
    public static var screenOrientation: UIInterfaceOrientation{
        return UIApplication.shared.statusBarOrientation
    }
    
    /// 状态栏高度
    public static var screenStatusBarHeight: CGFloat{
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 除去状态栏高度的屏幕尺寸。    
    public static var screenHeightWithOutStatusBar: CGFloat{
        if screenOrientation.isPortrait{
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else{
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
}
