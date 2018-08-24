//
//  UITableView+Extension.swift
//  PermitAssistantSwift
//
//  Created by 谭林杰 on 2018/7/25.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit

extension UITableView{
    
    /// 刷新数据
    ///
    /// - Parameter completion: 刷新完成
    func reloadData(_ completion:@escaping()->()) -> Void {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { (_) in
            completion()
        }
    }
    /// -MARK: 不懂
    func insertRowsAtBottom(_ rows: [IndexPath]) {
        //保证 insert row 不闪屏
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.beginUpdates()
        self.insertRows(at: rows, with: .none)
        self.endUpdates()
        self.scrollToRow(at: rows[0], at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
    
    /// 获得所有的row个数
    ///
    /// - Returns: Int
    func getTotlaRows() -> Int {
        var i = 0
        var rowCount = 0
        while i<self.numberOfSections {
            rowCount += self.numberOfRows(inSection: i)
            i += 1
        }
        return rowCount;
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
