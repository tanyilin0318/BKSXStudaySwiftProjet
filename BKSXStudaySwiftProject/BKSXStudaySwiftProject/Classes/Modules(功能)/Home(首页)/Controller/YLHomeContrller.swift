//
//  YLHomeContrller.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/5/23.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

class YLHomeContrller: UIViewController ,UITableViewDataSource ,UITableViewDelegate {

    fileprivate var tableView : UITableView?;
    var titleArray : Array<String> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学习列表";
        titleArray = ["网络请求","图表","chat","my"];
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: .zero, style: .plain);
        tableView?.backgroundColor = UIColor.white;
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView(frame: .zero)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "titleCell");
        view.addSubview(tableView!);
        
        tableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalToSuperview()
        })
        
        YLProgressHUD.yl_showWarningWithStatus("ddfsfsd")

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell");
        cell?.textLabel?.text = titleArray[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            self.navigationController?.pushViewController(YLChatViewController(), animated: true);
        case 3:
            self.navigationController?.pushViewController(YLMyMsgViewController(), animated: true);
        default:
            print("dd");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
