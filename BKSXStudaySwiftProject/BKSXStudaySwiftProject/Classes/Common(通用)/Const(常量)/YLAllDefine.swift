//
//  YLAllDefine.swift
//  CYCourtManagerSwift
//
//  Created by 谭林杰 on 2018/4/2.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit


///***=========================== SYSTEM ================================***///

let SCREEN_BOUNDS = UIScreen.main.bounds;

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height

let SCREEN_MAX_LENGTH  = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let IS_IPHONE_4_OR_LESS = SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = SCREEN_MAX_LENGTH == 812.0

let STATUS_NAV_BAR_Y:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0
let TABBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 83.0 : 49.0
let STATUSBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 44.0 : 20.0


///***=========================== COLOR ================================***///

/// tabbar背景色
let TABBAR_BACK_COLOR = UIColor.init(red: 0.890, green: 0.890, blue: 0.886, alpha: 1.0);
/// tabbar字体颜色
let TABBAR_NOR_COLOR = UIColor.init(red: 0.302, green: 0.302, blue: 0.302, alpha: 1.0);
/// 主题色（tabbar选中，）
let THEME_COLOR = UIColor.withHex(hexString: "ff7100");
/// 标题颜色
let TITLE_COLOR = UIColor.withHex(hexString: "4d4d4d");
/// 副标题颜色
let SUBTITLE_COLOR = UIColor.withHex(hexString: "999999");
/// 背景色
let BackGround_COLOR = UIColor.withHex(hexString: "f5f6f3");


///***=========================== FONT ================================***///

let FONT_LITTLE = UIFont.systemFont(ofSize: 10);
let FONT_SMALL = UIFont.systemFont(ofSize: 12);
let FONT_MIDDLE = UIFont.systemFont(ofSize: 14);
let FONT_BIG = UIFont.systemFont(ofSize: 16);
let FONT_LARGE = UIFont.systemFont(ofSize: 18);
let FONT_VERYBIG = UIFont.systemFont(ofSize: 20);
///***=========================== HEIGHT ================================***///

let NEWTASKCELL_HEIGHT = 80.0





class YLAllDefine: NSObject {

}
