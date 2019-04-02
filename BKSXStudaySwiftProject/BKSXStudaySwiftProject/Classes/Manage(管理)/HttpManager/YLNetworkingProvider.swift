//
//  YLNetworkingProvider.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import Moya
import Result
import SwiftyJSON
import ObjectMapper

/// 成功
typealias SuccessStringClosure = (_ result: String) -> Void
typealias successModelClosure = (_ result : Mappable?) -> Void
typealias successArrModelClosure = (_ result:[Mappable]?) -> Void
typealias successJSONClosure = (_ result:JSON) -> Void

// 失败
typealias FailClosure = (_ result: String?) -> Void

public class YLNetworkProvider{
    ///
    static let shared = YLNetworkProvider()
    private init(){}
    private let failInfo = "数据解析失败"
    
    
    ///请求JSon数据
    func requestDataWithTargetJSON<T:TargetType>(target:T,successClosure:@escaping successJSONClosure ,failClosure:@escaping FailClosure) -> Void {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeOutClosure(target: target))
        _ = requestProvider.request(target) { (result) in
            switch result{
            case let .success(respones):
                do{
                    let mapJson = try respones.mapJSON()
                    let json = JSON(mapJson)
                    guard let _ = json.dictionaryObject else{
                        failClosure(self.failInfo)
                        return
                    }
                    successClosure(json["data"])
                }catch{
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }
    
    ///请求数组对象的Json数据
    func requestDataWithTargetArrModelJSON<T:TargetType,M:Mappable>(target:T,model:M,successClosure:@escaping successArrModelClosure,failClosure:@escaping FailClosure) -> Void {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeOutClosure(target: target))
        let _ = requestProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                do{
                    let json = try response.mapJSON()
                    let arr = Mapper<M>().mapArray(JSONObject: JSON(json).object)
                    successClosure(arr)
                }catch{
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
        
    }
    
    /// 请求对象json数据
    func requestDataWithTargetModelJSON<T:TargetType ,M:Mappable>(target:T ,model:M,successClosure:@escaping successModelClosure,failClosure:@escaping FailClosure) -> Void {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeOutClosure(target: target))
        let _ = requestProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                do{
                    let json = try response.mapJSON()
                    let model = Mapper<M>().map(JSONObject: JSON(json).object)
                    successClosure(model)
                }catch{
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
        
        
    }
    
    
    /// 请求string数据
    func requestDataWithTargetString<T:TargetType>(target:T,successClosure:@escaping SuccessStringClosure,failClosure:@escaping FailClosure) -> Void {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeOutClosure(target: target))
        let _ = requestProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                do{
                    let str = try response.mapString()
                    successClosure(str)
                    
                }catch{
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
        
    }
    
    
    ///设置一个公共请求超时时间
    private func requestTimeOutClosure<T:TargetType>(target:T) -> MoyaProvider<T>.RequestClosure {
        let requestTomeOutClosure = {
            (endpoint:Endpoint, done:@escaping MoyaProvider<T>.RequestResultClosure) in
            do{
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 20 //设置请求超时时间
            }catch{
                return
            }
        }
        return requestTomeOutClosure
    }
}
