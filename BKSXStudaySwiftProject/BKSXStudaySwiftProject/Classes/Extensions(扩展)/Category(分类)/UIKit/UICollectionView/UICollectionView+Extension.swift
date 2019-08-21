//
//  UICollectionView+Extension.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/8/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionView{
    
    /// 注册cell
    func yl_registerCell<T:UICollectionViewCell>(cell : T.Type) -> Void where T :RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    ///从缓存池子拿出cell
    func yl_dequeueReusableCell<T:UICollectionViewCell>(indexPath :IndexPath) -> T where T:RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// 注册头部
    func yl_registerSupplementaryHeaderView<T:UICollectionReusableView>(reusableView:T.Type) -> Void where T :RegisterCellFromNib{
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }else{
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    /// 获取可充用头部
    func yl_dequeueReusableSupplementaryHeaderView<T:UICollectionReusableView>(indexPath:IndexPath) -> T where T:RegisterCellFromNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
