//
//  YLBaseUIWebViewController.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/8/1.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLBaseUIWebViewController: YLBaseScrollViewController,UIWebViewDelegate {
    var webView = UIWebView()
    
    var url: URL?
    
//    init(URL: Foundation.URL?){
//        url = URL
//        
//        super.init()
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        userDefultScrollView = false
        
        super.loadView()
        
        scrollView = webView.scrollView
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        guard let url = url else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(request: urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
