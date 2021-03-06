//
//  YLNetworking.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/17.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import Alamofire

enum YLMethod {
    case GET
    case POST
}

let ZJ_DOUYU_TOKEN : String = "ZJ_DOUYU_TOKEN"

class YLNetworking {
    
    func requestData(type:YLMethod , URLString:String , parameters:[String : String]? = nil,finishCallBack:@escaping (_ responseCall : Data)->()) {
        
        let type = type == YLMethod.GET ? HTTPMethod.get : HTTPMethod.post
        // 配置 httpheaders
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
        Alamofire.request(URLString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            // 处理 cookie
            let headerFields = response.response?.allHeaderFields as! [String : String]
            let url = response.request?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields , for: url!)
            var cookieArray = [[HTTPCookiePropertyKey : Any]]()
            for cookie in cookies{
                cookieArray.append(cookie.properties!)
            }
            if !(UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN) != nil){
                // 保存 cookie
                UserDefaults.standard.set(cookieArray, forKey: ZJ_DOUYU_TOKEN)
            }else{
                print("token\(String(describing: UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN)))")
            }
            print("Method:\(type)请求\nURL: \(URLString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(response.request?.url ?? "url")
                
                print(parameters ?? String())
            }
            
            guard let result = response.result.value else {
                print(response.result.error ?? "错误❌")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            
            // 返回字典类型 Data
            if let dataDict = dict["data"] as? [String : Any] {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                print(dict)
                if jsonData != nil {
                    finishCallBack(jsonData!)
                    return
                }
            }
            
            // 返回数组类型Data
            if ((dict["data"] as? [Any]) != nil) {
                let arrData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                print(dict)
                if arrData != nil {
                    finishCallBack(arrData!)
                }
            }
            
        }
        
        
        
    }
}
