//
//  YLWebViewProtocol.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/6/25.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit
import WebKit

protocol WebViewCommonProtocol {
    
    var title : String? { get }
    var url : URL? { get }
    var scrollView : UIScrollView { get }
    
    var canGoBack : Bool { get }
    var canGoForwoard : Bool { get }
    var isLoading : Bool { get }
    var isLoadingMainFrame : Bool { get }
    var estimatedProgress : Double { get }
    
    func common_goBack()
    func common_goForward()
    func common_reload()
    
    func load(url : URL)
    func load(request : URLRequest)
    
    func stopLoading()
    // 评审evaluate
    func evaluateJavaScript(_ javaScriptString : String , completionHandler : ((Any?,Error) -> Void)?)
}


fileprivate var keyForEstimatedProgerss : Int = 0
fileprivate var KeyForLoadingUIMainFrame : Int = 0
fileprivate var keyForLoadingWKMainFrame : Int = 0

// MARK: -UIWebView
extension UIWebView : WebViewCommonProtocol{
    var title: String? {
        return stringByEvaluatingJavaScript(from: "document.title")
    }
    
    var url: URL? {
        return request?.url
    }
    
    var canGoForwoard: Bool {
        return self.canGoForwoard
    }
    
    /// 需在委托方法中设置，才能get到有效值
    var isLoadingMainFrame: Bool {
        get{
            return objc_getAssociatedObject(self, &KeyForLoadingUIMainFrame) as! Bool
        }
        
        set{
            objc_setAssociatedObject(self, &KeyForLoadingUIMainFrame, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 需在委托方法中设置，才能get到有效值
    var estimatedProgress: Double {
        get {
            return objc_getAssociatedObject(self, &keyForEstimatedProgerss) as! Double
        }
        
        set {
            objc_setAssociatedObject(self, &keyForEstimatedProgerss, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func common_goBack() {
        goBack()
    }
    
    func common_goForward() {
        goForward()
    }
    
    func common_reload() {
        reload()
    }
    
    func load(url: URL) {
        let request = URLRequest(url: url)
        loadRequest(request)
        
    }
    
    func load(request: URLRequest) {
        loadRequest(request)
    }
    
    func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error) -> Void)?) {
        let str = stringByEvaluatingJavaScript(from: javaScriptString)
    }
   
}


// MARK: - WKWebView
extension WKWebView : WebViewCommonProtocol {
    func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error) -> Void)?) {
        
    }
    
    var canGoForwoard: Bool {
        return self.canGoForwoard
    }
    
    var isLoadingMainFrame: Bool {
        get {
            return objc_getAssociatedObject(self, &keyForLoadingWKMainFrame ) as! Bool
        }
        
        set {
            objc_setAssociatedObject(self, &keyForLoadingWKMainFrame, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func common_goBack() {
        goBack()
    }
    
    func common_goForward() {
        goForward()
    }
    
    func common_reload() {
        reload()
    }
    
    func load(url: URL) {
        let request = URLRequest(url: url)
        load(request: request)
    }
    
    func load(request: URLRequest) {
        load(request: request)
    }
    
}


protocol webViewHandlerURLProtocol {
    ///WKNavigationType 与 UIWebViewNavigationType 一一对应。需注意的是：前者other为-1，而后者为5
    func handle(in hostViewController :UIViewController ,webView : WebViewCommonProtocol ,request :URLRequest ,navigationType:WKNavigationType ,decisionHandler: @escaping(WKNavigationActionPolicy) -> Void) -> Bool
}

extension webViewHandlerURLProtocol{
    @discardableResult
    func handle(in hostViewController :UIViewController ,webView : WebViewCommonProtocol ,request :URLRequest ,navigationType:WKNavigationType ,decisionHandler: @escaping(WKNavigationActionPolicy) -> Void) -> Bool{
        
        
        switch navigationType {
        case .linkActivated://0
            break
        case .formSubmitted://1
            break
        case .backForward://2
            break
        case .reload://3
            break
        case .formResubmitted://4
            break
        case .other://开始时是other，即-1，其他几个都是用户行为
            break
        }
        
        /*
         Error Domain=WebKitErrorDomain Code=102 "Frame load interrupted" UserInfo={_WKRecoveryAttempterErrorKey=<WKReloadFrameErrorRecoveryAttempter: 0x170437b20>, NSErrorFailingURLStringKey=itms-appss://itunes.apple.com/cn/app/yu-piao-er-dian-ying-yan-chu/id481589275?mt=8, NSErrorFailingURLKey=itms-appss://itunes.apple.com/cn/app/yu-piao-er-dian-ying-yan-chu/id481589275?mt=8, NSLocalizedDescription=帧框加载已中断}
         */
        
        guard let url = request.url ,let uc = URLComponents(url: url, resolvingAgainstBaseURL: true),let scheme = uc.scheme else {
            print(#function,"【WKWebView】这个request不正常\(request)")
            decisionHandler(.cancel)
            return false
        }
        
        //// 有些iframe 带 srcdoc 和 src 属性，这种跳转就是about:srcdoc吗？是的
        if url.absoluteString.hasPrefix("about:"){
             // “软件许可及服务协议”跳转到“微信公众平台服务协议”后再跳转时，会出现target="_blank"，
            decisionHandler(.allow)
            return true // 有些页面会一直尝试跳转about:blank，比如youku，
        }
        
        let isNormalURL = (scheme == "http" || scheme == "https")
        if !isNormalURL {/* && UIApplication.shared.canOpenURL(url) */
            decisionHandler(.cancel)
            
            DispatchQueue.main.async {
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url, options: [.universalLinksOnly : false], completionHandler: { (completed) in
                        print("【WKWebView】\(completed ? "succeeded to" : "failed to") open another app with url: \(url)")
                    })
                }else {
                    UIApplication.shared.canOpenURL(url)
                }
            }
            
            return false
        }else if url.host == "itunes.apple.con" {// 跳转app store 安装app，或跳转其他注册了相应scheme的第三方app
            
            decisionHandler(.cancel)
            
            DispatchQueue.main.async {
                let ac = UIAlertController(title: nil, message: "将会离开\"\"\n并跳转到 App Store", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { (aa) in
                    
                    if #available(iOS 10.0, *){
                        UIApplication.shared.open(url, options: [.universalLinksOnly : false], completionHandler: { (completed) in
                            print("【WKWebView】open App Store with url: \(url)")
                        })
                    }else {
                        UIApplication.shared.canOpenURL(url)
                    }
                }))
                hostViewController.present(ac, animated: true, completion: nil)
            }
            return false
        } else {
            decisionHandler(.allow)
            return true
        }
    }
}


extension UIWebView : webViewHandlerURLProtocol{
    
}

extension WKWebView : webViewHandlerURLProtocol{
    
}

// 添加一些实用的方法

extension WKWebView{
    
    // sync version

}


extension UIWebView{
    
    func setup(autuPlayBackVideo : Bool = true){
        guard autuPlayBackVideo else {
            return
        }
        allowsInlineMediaPlayback = !autuPlayBackVideo
        mediaPlaybackRequiresUserAction = !autuPlayBackVideo
    }
}












