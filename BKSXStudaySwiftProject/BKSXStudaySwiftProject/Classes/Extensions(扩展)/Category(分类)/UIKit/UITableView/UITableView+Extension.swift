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
    
    ///注册cell的方法
    func yl_registerCell<T: UITableViewCell>(cell : T.Type) -> Void where T:RegisterCellFromNib {
//        if let nib = T.nib {
//            register(nib, forCellReuseIdentifier: T.identifier)
//        }else{
//            register(cell, forCellReuseIdentifier: T.identifier)
//        }
        
        register(cell, forCellReuseIdentifier: T.identifier)
    }
    
    /// 从缓存池出对已经存在的队列 cell
    func yl_dequeueReusableCell<T :UITableViewCell>(indexPath :IndexPath) -> T where T : RegisterCellFromNib {

        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// 从缓存池出对已经存在的队列 tableheaderfooterview
    func yl_dequeueReusableHeaderFooterView<T : UITableViewHeaderFooterView>() -> T where T :RegisterCellFromNib {
        
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
    
    
    func totalRows() -> Int {
        var i = 0
        var rowCount = 0
        while i < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: i)
            i += 1
        }
        return rowCount
    }
    
    var lastIndexPath: IndexPath? {
        if (self.totalRows()-1) > 0{
            return IndexPath(row: self.totalRows()-1, section: 0)
        } else {
            return nil
        }
    }
    
    //插入数据后调用
    func scrollBottomWithoutFlashing() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.scrollToRow(at: indexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
    
    //键盘动画结束后调用
    func scrollBottomToLastRow() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        self.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y:self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    var isContentInsetBottomZero: Bool {
        get { return self.contentInset.bottom == 0 }
    }
    
    func resetContentInsetAndScrollIndicatorInsets() {
        self.contentInset = UIEdgeInsets.zero
        self.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    
    
}
