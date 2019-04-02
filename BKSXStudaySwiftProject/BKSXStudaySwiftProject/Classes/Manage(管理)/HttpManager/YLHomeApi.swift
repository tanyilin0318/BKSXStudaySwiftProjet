//
//  YLHomeApi.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import UIKit
import Moya

let HomeProvider = MoyaProvider<HomeApi>()



public enum HomeApi {
    case oneBase
    case twoBase
}

extension HomeApi : TargetType{
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .oneBase:
            return URL(string: "http")!
        case .twoBase:
            return URL(string: "httpb")!

        }
    }
    
    /// 各请求具体地址
    public var path: String {
        switch self {
        case .oneBase:
            return ""
        case .twoBase:
            return ""
        }
    }
    
    /// 请求方式
    public var method: Moya.Method {
        switch self {
        case .oneBase:
            return .get
        case .twoBase:
            return .post
        }
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .oneBase:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }

    
}
