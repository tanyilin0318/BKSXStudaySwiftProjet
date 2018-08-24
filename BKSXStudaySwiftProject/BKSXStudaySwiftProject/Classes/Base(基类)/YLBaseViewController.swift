//
//  YLBaseViewController.swift
//  protocolDelegate
//
//  Created by 谭林杰 on 2018/6/15.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import Reachability

public enum UINavigationBarLeftButtonType : Int {
    case none
    case done
    case settings
    case mueu
    case text
}

public enum UINavigationBarRightButtonType : Int {
    case none
    case done
    case settings
    case mueu
    case text
}

let commonHorizontalMargin: CGFloat = 14

/// 加载数据
protocol contentLoadingProtocol {
    func reloadContent(animated :Bool)
    func loadContent(animated :Bool)
    func clearContent(animated :Bool)
}


/// <#Description#>
protocol pullActionForScrollView {
    func topPull(sender : UIControl?)
    func bottomPull(sender : UIControl?)
}


fileprivate let logLifeCycle = false
fileprivate let logTag = "YLBaseViewController"

protocol autoRefreshable {
    var firstLoad:Bool {get set}
    var shouldAutoRefresh:Bool {get set}
    var autoReFreshInterval:TimeInterval {get set}
    var refreshDate:Date? {get set}
}

/// 如何使用NetworkWarningView？
/// 1. 提供 NetworkWarningView 的 superview，即初始化 errorContentView，若不设置则 NetworkWarningView 会加到 self.view （默认居中置于superview中）
/// 2. 确保已提供重加载请求入口 topPull(_:) 方法
/// 3. 在网络请求的 fail 处理分支设置networkWarningView.warningType = .loadFailed，在其 success 处理分支设置 networkWarningView.warningType = .noError
/// 4. 处理 clearContent(_:) 和 loadContent(_:)，分别对应 .loadFailed 和 .noError 逻辑 ———— 对于 UITableView 和 UICollectionView，通常只需要将其数据源置空和填入数据并 reloadData() 就行 （此部分跟具体业务关系挺大，有些业务在出错时只需要隐藏部分内容，有些则需要全隐藏，有些还要处理子模块的数据加载）

open class YLBaseViewController: UIViewController{
    
    let textColor = UIColor.black
    
    let textFont = UIFont.systemFont(ofSize:  18.0 )

    var leftButton : UIButton?
    var rightButton : UIButton?
    
    var leftBtnItem : UIBarButtonItem?
    var rightBtnItem : UIBarButtonItem?
    
    var leftButtonType : UINavigationBarLeftButtonType?
    var rightButtonType : UINavigationBarRightButtonType?
    
//    var navigationY : CGFloat  // 导航条 top 的y值 用于记录
//    var navBarY : CGFloat
//    var verticalY : CGFloat
    
    var reachability : Reachability?
    
    
    /// networkWarningView 容器，为空则直接放在view里，并居中放置
    var errorContentView:UIView? = nil
    let netWorkWarningView = YLNetworkWarningView(frame: .zero)
    
    var hiddensToolBarWhenPushed = true //默认不适用Toolbar
    
    private(set) var appeared = false
    
    //MARK: - 自动刷新
    var firstLoad = true //首次加载
    var shouldAutoRefresh = false //自动刷新
    var autoRefreshInterval = 3600.0
    var refreshDate : Date? // 需要在请求成功后设置其数值 为 Date（）
    
    // MARK: -- 设置导航左右按钮
    
    /// 左键按钮
    public func setUpNavigationLeftBar(leftBtnType : UINavigationBarLeftButtonType ,leftButtonText : String) -> Void {
        hidenNavigationBar(false)
        self.leftButtonType = leftBtnType
        if leftBtnType != .none {
            leftButton = UIButton(type: .custom)
            leftButton?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            leftButton?.addTarget(self, action: #selector(leftNavigationButtonClickAction(_:)), for: .touchUpInside)
            if leftBtnType == .text {

                leftButton?.setTitle(leftButtonText, for: .normal)
                leftButton?.setTitle(leftButtonText, for: .highlighted)
                leftButton?.setTitleColor(textColor, for: .normal)
                leftButton?.setTitleColor(textColor, for: .highlighted)
                leftButton?.titleLabel?.font = textFont
            }else {
                let menuImage : UIImage? = ((leftBtnType == .settings) ? UIImage(named : "setting") : (leftBtnType == .mueu) ? UIImage(named: "menu") : nil)

                leftButton?.setImage(menuImage, for: .normal)
                leftButton?.setImage(menuImage, for: .highlighted)
            }
            
            leftBtnItem = UIBarButtonItem.init(customView: leftButton!)
            let negativeSpace : UIBarButtonItem? = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            self.navigationItem.setLeftBarButtonItems([negativeSpace! , self.leftBtnItem!], animated: false)
            
        }
    }
    
    @objc func leftNavigationButtonClickAction(_ sender : AnyObject) -> Void {
        

    }
    
    /// 右键按钮
    public func setUpNavigationRightBar(rightBtnType:UINavigationBarRightButtonType ,rightButtonTitle : String = "") -> Void {
        hidenNavigationBar(false)
        rightButtonType = rightBtnType
        
        if rightBtnType != .none {
            rightButton = UIButton(type: .custom)
            rightButton?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            rightButton?.addTarget(self, action: #selector(rightNavigationButtonClickAction(_:)), for: .touchUpInside)
            
            if rightBtnType == .text {
                rightButton?.setTitle(title, for: .normal)
                rightButton?.setTitle(title, for: .highlighted)
                rightButton?.setTitleColor(textColor, for: .normal)
                rightButton?.setTitleColor(textColor, for: .highlighted)
                rightButton?.titleLabel?.font = textFont
            }else{
                
                let menuImage : UIImage? = ((rightBtnType == .settings) ? UIImage(named: "setting") : (rightBtnType == .mueu) ? UIImage(named: "menuButton") : nil)
                rightButton?.setImage(menuImage, for: .normal)
                rightButton?.setImage(menuImage, for: .highlighted)
            }
            rightBtnItem = UIBarButtonItem(customView: rightButton!)
            let negativeSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            navigationItem.setRightBarButtonItems([negativeSpace,rightBtnItem!], animated: false)
            
        }
    }
    
    @objc func rightNavigationButtonClickAction(_ sender : AnyObject) -> Void {

    }
    
    ///标题位置控件
    public func setUpNavigationBarWithTitleImage(_ imageName : String , showBackButtonIfNeeded show : Bool) -> Void {
        hidenNavigationBar(false)
        let titleImage = UIImageView(image: UIImage(named: imageName))
        self.navigationItem.titleView = titleImage
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClick(Tap:)));
        titleImage.addGestureRecognizer(tap);

    }
    
    /// 设置可点击标题
    public  func setNavigationBarTitle(title: String)
    {
        if title.count > 0 {
            self.navigationItem.title = title
            let navTitleLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 44));
            navTitleLable.numberOfLines = 0 ;
            navTitleLable.text = title;
            navTitleLable.textAlignment = .center;
            navTitleLable.backgroundColor = UIColor.clear;
            navTitleLable.isUserInteractionEnabled = true;
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClick(Tap:)));
            navTitleLable.addGestureRecognizer(tap);
            self.navigationItem.titleView = navTitleLable;
        }
    }
    
    @objc func titleClick(Tap tap:UITapGestureRecognizer) -> Void {
        

    }
    
    public func hidenNavigationBar(_ hide : Bool) -> Void {
        if self.navigationController != nil {
            self.navigationController?.isNavigationBarHidden = hide
        }
    }
    
    ///
    public func hidenNavBarShaddow(hiden : Bool) -> Void {
        navigationController?.navigationBar.setValue(hiden, forKey: "hidesShadow")
    }
    
    ///回到某个控制器
    public func popToIndexController(_ backIndex : Int ,animated animate : Bool) -> Void {
        if ((navigationController?.viewControllers.count)!  - backIndex) > 0 {
            let controller : YLBaseViewController = (navigationController?.viewControllers[((navigationController?.viewControllers.count)! - 1 - backIndex)] as! YLBaseViewController)
            self.navigationController?.popToViewController(controller, animated: true)
            
        }
    }
    
    ///设置导航背景图
    public func navigationBarBackGroundImage(backGroundImage imageName:String) -> Void {
        var image : UIImage?
        
        if imageName.isEmpty{
            image = UIImage.imageWithColor(color: UIColor.white)
        }else {
            image = UIImage(named: imageName)
        }
        
        navigationController?.navigationBar.setBackgroundImage(image, for: .any, barMetrics: .default)
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.navigationBar.shadowImage = image
    }
    
    ///设置导航返回图片
    public func navigationBarBackImage(backImage imageName : String) -> Void{
        let image = UIImage.init(named: imageName)
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.navigationBar.shadowImage = image
        
    }
    
    ///设置导航艺术字标题
    public func navigationAttributedString(titleStr title:NSMutableAttributedString) -> Void {
        
        let navTitleLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 44));
        navTitleLable.numberOfLines = 0 ;
        navTitleLable.attributedText = title;
        navTitleLable.textAlignment = .center;
        navTitleLable.backgroundColor = UIColor.clear;
        navTitleLable.isUserInteractionEnabled = true;
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClick(Tap:)));
        navTitleLable.addGestureRecognizer(tap);
        self.navigationItem.titleView = navTitleLable;
        
    }
    
    ///改变导航条高度
    public func changeNavigationBarHeight(navBarHeight height:CGFloat) -> Void {
        var react = navigationController?.navigationBar.frame
        react?.size.height = height
        navigationController?.navigationBar.frame = react!
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.frame = react!
        }
    }
    
    ///改变导航条y值
    func navigationBarTranslationY(Y TranslationY : CGFloat) -> Void {
//        self.navigationController?.navigationBar.transform = CGAffineTransform.in
    }
    
    ///查找底部黑线
    
    
    /// 实时监听网络状态
    func monitorNetStatus() -> Void {
        
        stopNotifier()
        setupReachability(nil, userClosures: false)
        startNotifier()
    }
    
    func startNotifier() -> Void {
        print("---- start 开始 通知")
        do {
            try reachability?.startNotifier()
        } catch {
            // 提示
            print("没创建成功！")
            return
        }
    }
    
    func stopNotifier() -> Void {
        print("--- stop 结束 通知")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
        reachability = nil
    }
    
    func setupReachability(_ hostName:String? , userClosures : Bool) -> Void {
        
        let reach : Reachability?
        if let hostName = hostName {
            reach = Reachability(hostname: hostName)
        }else{
            reach = Reachability()
        }
        
        reachability = reach
        
        
        if userClosures {
            
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reach)
        }
    }
    
    @objc func reachabilityChanged(_ note : Notification) -> Void {
        let reachab = note.object as! Reachability
        
//        print(reachab.connection)
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = navigationController, nav.topViewController == self, nav.isToolbarHidden != hiddensToolBarWhenPushed {
            nav.setToolbarHidden(hiddensToolBarWhenPushed, animated: animated)
        }
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override open func viewDidLoad() {
        super.viewDidLoad()  
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isNavigationBarHidden = false
        //
//        edgesForExtendedLayout = UIRectEdge
        //
//        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = UIColor.white
        // 上下是否要被 navigationBar 和 tooBar 覆盖的问题，都在下面这两个属性——————它们是协作关系
//        automaticallyAdjustsScrollViewInsets = false
//        edgesForExtendedLayout = UIRectEdge()
//
        hideBackBarButtionTitle()//

        /// 监控网络
        monitorNetStatus()
    }

    
   

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        //关闭网络消息状态监听
        reachability?.stopNotifier()
        //移除网络消息通知
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }

}


