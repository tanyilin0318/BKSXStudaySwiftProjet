//
//  YLChatViewController.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/5.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import SnapKit

class YLChatViewController: UIViewController ,UITextViewDelegate{
    
    lazy var listTableView: UITableView = {
        let listTableView = UITableView(frame: .zero, style: .plain)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.backgroundColor = UIColor.clear
        listTableView.separatorStyle = .none
        listTableView.backgroundView = UIImageView.init(image: UIImage(named: "chat_background"))
        return listTableView
    }()
    
    /// 控制滑动取消后的结果，决定是停止录音还是取消录音
    lazy var finishRecording = true
    /** 控件*/
    var chatActionBarView: YLChatActionBarView!  // 底部按钮的bar
    var voiceIndicatorView: YLChatVoiceIndicatorView! //声音显示 弹窗
    var shareMoreView : YLChatShareMoreView! //加号 分享键盘
    var emotionInputView : YLChatEmotionInputView! // 表情键盘
    
    var actionBarPaddingBottomConstranit : Constraint! //action bar 的 bottom Constraint
    var keyboardHeightConstraint : NSLayoutConstraint! //键盘高度 constraint

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "姓名（联系人）"
        view.backgroundColor = UIColor.white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        /* tableView init */
//        listTableView.yl_registerCell(cell: UITableViewCell.self)
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        /*  view*/
        
        
        setupSubviews(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension YLChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YLChatViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        cell?.backgroundColor = UIColor.red
        return cell!
    }
}

















