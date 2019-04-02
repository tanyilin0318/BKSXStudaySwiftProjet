//
//  ExtensionsCommonTool.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/8/31.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterCellFromNib {
   
}

extension RegisterCellFromNib{
    static var identifier: String {
        return "\(self)"
    }

    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
