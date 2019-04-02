//
//  YLConfig.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation


class YLConfig: NSObject {
    static let testUserID = "wx1234skjksmsjdfwe234"
    static let ExpressionBundle = Bundle(url: Bundle.main.url(forResource: "Expression", withExtension: "bundle")!)
    static let ExpressionBundleName = "Expression.bundle"
    static let ExpressionPlist = Bundle.main.path(forResource: "Expression", ofType: "plist")

}
