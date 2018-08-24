//
//  YLBaseScrollViewController.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/11.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLBaseScrollViewController: YLBaseViewController , UIScrollViewDelegate{
    
    var scrollView = UIScrollView()
    
    var userDefultScrollView = true
    
    var positionOfRefreshControl : UIRectEdge = UIRectEdge(){
        didSet{
            if positionOfRefreshControl.contains(.top) {
                
            }else{
                
            }
            
            if positionOfRefreshControl.contains(.bottom) {
                
            }else {
                
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        guard userDefultScrollView else {
            return
        }
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth ,.flexibleHeight]
        view.addSubview(scrollView)
        scrollView.delegate = self
    }
    
    fileprivate var oldPositionOfRefreshControl:UIRectEdge = UIRectEdge()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
