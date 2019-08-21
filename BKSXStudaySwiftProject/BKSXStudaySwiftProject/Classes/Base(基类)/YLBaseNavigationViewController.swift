//
//  YLBaseNavigationViewController.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit


class Common{
    static let titleAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.backgroundColor : UIColor.white]
    
    static let netWorkTimeOut:TimeInterval = 10
    
    static let displayName = App.appName
    
    //MARK: - network
    static var networkActivityCount: Int = 0{
        didSet{
            if networkActivityCount < 0{
                networkActivityCount = 0
            } else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = networkActivityCount > 0
            }
        }
    }
    
    
}

class YLBaseNavigationViewController: UINavigationController {
    
    ///一个布尔值，指示导航控制器是否正在堆栈上推新的视图控制器。
    fileprivate(set) var isDuringPushAnimation = false
    
    ///这个班真正的代表。“委托”属性仅用于保持内部状态。
    ///动画-我们需要知道动画什么时候结束，并且这个信息只能得到from`navigationController:didShowViewController:animated:
    fileprivate(set) weak var realDelegate : UINavigationControllerDelegate? = nil
    
    fileprivate(set) var appeared = false
    
    fileprivate var delayedPushViewControllers = [UIViewController]()
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if nil == delegate {
            delegate = self as? UINavigationControllerDelegate
        }
        
        interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(self,#function,animated)
        appeared = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(self,#function,animated)
        appeared = false
    }

    override var delegate: UINavigationControllerDelegate?{
        get{
            return super.delegate
        }
        
        set{
            realDelegate = newValue === self ? nil : newValue
            super.delegate = newValue == nil ? nil : self as? UINavigationControllerDelegate
        }
    }
    
     override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        print(self , #function ,animated)
        return vc
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcArray = super.popToViewController(viewController, animated: animated)
        print(self, #function, viewController, animated)
        return vcArray
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcArray = super.popToRootViewController(animated: animated)
        print(self, #function, animated)
        return vcArray
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        print(self, #function, viewControllerToPresent, flag)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        print(self, #function, flag)
        super.dismiss(animated: flag, completion: completion)
    }
    
    weak var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
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
// MARK: - UINavigationControllerDelegate
    
    ///push 或 pop 到 viewController 过程：本方法调用都在 viewController 的 viewWillAppear() 之后，viewWillLayoutSubviews() 之前
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        print(self,#function,viewController,animated)
        realDelegate?.navigationController!(navigationController, willShow: viewController, animated: animated)
    }
    
    ///// push 或 pop 到 viewController 过程：本方法调用都在 viewController 的 viewDidAppear() 之后
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        print(self,#function,viewController,animated)
        assert(interactivePopGestureRecognizer?.delegate === self, "AHKNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.")
        
        isDuringPushAnimation = false
        
        realDelegate?.navigationController!(navigationController, didShow: viewController, animated: animated)
        
        switch delayedPushViewControllers.count {
        case 0:
            break
        case 1:
            pushViewController(delayedPushViewControllers[0], animated: animated)
            delayedPushViewControllers.removeAll()
        default:
            let vcArray = viewControllers + delayedPushViewControllers
            setViewControllers(vcArray, animated: animated)
            delayedPushViewControllers.removeAll()
        }
    }
    
    ///手势驱动的返回动画（手势控制动画进度）
    func navigationController(_ navigationController:UINavigationController, interactionControllerFor animationController:UIViewControllerAnimatedTransitioning) -> UIViewControllerAnimatedTransitioning? {
        
        if let rd = realDelegate {
            let result = rd.navigationController!(navigationController, interactionControllerFor: animationController)
            print(self,#function,animationController,rd,result as Any)
        }
        // print(navigationController.viewControllers.last!) // 手指驱动返回动画时，顶部的 viewController 已经被pop掉了，所以这儿print的是新的topViewController
        print(self,#function,animationController)
        return percentDrivenTransition as? UIViewControllerAnimatedTransitioning
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation:UINavigationController.Operation, from fromVC:UIViewController, to toVC:UIViewController) -> UIViewControllerAnimatedTransitioning {
        if let rd = realDelegate {
            let result = rd.navigationController!(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
            print(self,#function,operation,fromVC,toVC,rd)
            return result!
        }
        
        var result:UIViewControllerAnimatedTransitioning? = nil
        switch operation {
        case .none:
            break
        case .pop:
            if fromVC is ImageMoveTransitionFrom, toVC is ImageMoveTransitionTo{
                
            }

        case .push:
            if fromVC is ImageMoveTransitionFrom, toVC is ImageMoveTransitionTo{
                result = imageMovePushTransition()
            }

        @unknown default: break
            
        }
        
        print(self,#function,operation,fromVC,toVC)
        return result!
    }
    // 转向问题，不在委托方法中处理
    
    //    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {}
    //    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {}
    
}

extension YLBaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            // Disable pop gesture in two situations:
            // 1) when the pop animation is in progress
            // 2) when user swipes quickly a couple of times and animations don't have time to be performed
            return viewControllers.count > 1 && !isDuringPushAnimation
        } else {
            return true // default value
        }
    }
}




// MARK: - 业务需求
//
//// TODO: topViewController or visibleViewController ?
//extension YLBaseNavigationViewController {
//    // MARK: - Rotation
//    override var shouldAutorotate: Bool {
//        if let rvc = topViewController {
//            return rvc.shouldAutorotate
//        }
//        return false
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if let rvc = topViewController {
//            return rvc.supportedInterfaceOrientations
//        }
//        return .portrait
//    }
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        if let rvc = topViewController {
//            return rvc.preferredInterfaceOrientationForPresentation
//        }
//        return .portrait
//    }
//
//
//    // MARK: - Status Bar
//    override var childViewControllerForStatusBarStyle: UIViewController? {
//        return topViewController
//    }
//    override var childViewControllerForStatusBarHidden: UIViewController? {
//        return topViewController
//    }
//    override var prefersStatusBarHidden: Bool {
//        if let rvc = topViewController {
//            return rvc.prefersStatusBarHidden
//        }
//        return false
//    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if let rvc = topViewController {
//            return rvc.preferredStatusBarStyle
//        }
//        return .lightContent
//    }
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        if let rvc = topViewController {
//            return rvc.preferredStatusBarUpdateAnimation
//        }
//        return .fade
//    }
//}




/*
 
 // MARK: - Delegate Forwarder，来自NSObject的方法
 /// Thanks for the idea goes to: https://github.com/steipete/PSPDFTextView/blob/ee9ce04ad04217efe0bc84d67f3895a34252d37c/PSPDFTextView/PSPDFTextView.m#L148-164
 extension BaseNavigationController {
 
 override func responds(to aSelector: Selector!) -> Bool {
 let will = super .responds(to: aSelector)
 if let d = realDelegate, d.responds(to: aSelector) {
 return true
 }
 return will
 }
 
 // Swift无法实现下面两个方法，由于需转发的只是UINavigationConetrollerDelegate协议的方法，故不需借助下面两个方法
 // Unimplemented methods ———— Swift does not include `NSMethodSignature` and `NSInvocation`
 //    - (NSMethodSignature *)methodSignatureForSelector:(SEL)s
 //    {
 //        return [super methodSignatureForSelector:s] ?: [(id)self.realDelegate methodSignatureForSelector:s];
 //    }
 //
 //    - (void)forwardInvocation:(NSInvocation *)invocation
 //    {
 //        id delegate = self.realDelegate;
 //        if ([delegate respondsToSelector:invocation.selector]) {
 //            [invocation invokeWithTarget:delegate];
 //        }
 //    }
 }
 */













