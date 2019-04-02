//
//  YLHttpUploadManger.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/19.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON


typealias yl_parmeters = [String : AnyObject]
typealias SuccessClosure = (AnyObject) -> Void
typealias FailurClosure = (NSError) -> Void

class YLHttpUploadManger: NSObject {
    class var sharedInstance:YLHttpUploadManger {
        struct Static {
            static let instence:YLHttpUploadManger = YLHttpUploadManger()
        }
        return Static.instence
    }
    
    fileprivate override init() {
        super.init()
    }
}

/**
 
 --单张 / 多张 图片上传
 */

extension YLHttpUploadManger{
    
    /// 上传单张图片到服务器
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - parameters: 信息字典
    ///   - uploadImgURLStr: 上传地址
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func uploadSingleImage(_ image:UIImage ,
                           _ parameters:[String:String],
                           _ uploadImgURLStr:String,
                           successClosure:@escaping (_ imageModel : YLUploadImageModel) -> (),
                           progressValue:@escaping (_ value: Double) -> Void,
                           failClosure:@escaping FailClosure) -> Void {
        //开始
        let imageData = UIImageJPEGRepresentation(image, 0.7)

    
        Alamofire.upload(multipartFormData: { (multipartForData) in
            //采用post表单上传
            // 参数解释：
            //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
            if imageData != nil{
                multipartForData.append(imageData!, withName: "name", fileName: "fileName", mimeType: "image/jpeg")
            }
            
            for (key,value) in parameters{
                multipartForData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: uploadImgURLStr) { (result) in
            switch result{
                case .success(let request, _ , _):
                    request.responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case let .success(data):
                            /*
                             根据 JSON 返回格式，做好 UploadImageModel 的 key->value 映射, 这里只是个例子
                             */
                            
                            let imgModel = JSONDeserializer<YLUploadImageModel>.deserializeFrom(json: (data as! String), designatedPath: "data.data")
                            successClosure(imgModel!)
                        case let .failure(error):
                            failClosure(error.localizedDescription)
                        }
                        request.uploadProgress(queue: DispatchQueue.global(qos: .utility), closure: { (progress) in
                            print("图片上传进度\(progress.fractionCompleted)")
                            progressValue(progress.fractionCompleted
                            )
                        })
                    })
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    
    /// 多图片文件上传方法
    ///
    /// - Parameters:
    ///   - imagesArray: 图片数组
    ///   - parameter: 字典
    ///   - uploadURLStr: 上传路径
    ///   - successClosure: 成功
    ///   - failureClosure: 失败
    func uploadMultipleImages(_ imagesArray:[UIImage],
                              _ parameter:[String:String],
                              _ uploadURLStr:String,
                              successClosure:@escaping (_ imageModel:[YLUploadImageModel], _ imagesID :String) -> Void,
                              failureClosure:@escaping ()-> Void) -> Void {
        //--- 数组个数为0 退出
        guard imagesArray.count != 0 else {
            assert(imagesArray.count == 0, "无效的数组为0")
            failureClosure()
            return
        }
        
        // -- 内容不为image 退出
        for image in imagesArray {
            guard image.isKind(of: UIImage.self) else{
                assert(!image.isKind(of: UIImage.self), "数组内容不为图片格式")
                failureClosure()
                return
            }
        }
        
        let resultImageIdArray = NSMutableArray()
        let resultImageModelArray = NSMutableArray()
        
        let emtpyID = ""
        for _ in 0..<imagesArray.count{
            resultImageIdArray.add(emtpyID)
        }
        
        let group = DispatchGroup()
        var index = 0
        for (image) in imagesArray {
            group.enter()
            self.uploadSingleImage(image, parameter, uploadURLStr, successClosure: { (result) in
                /* 数据提取 */
                let imageID = result.imageId
                resultImageIdArray.replaceObject(at: index, with: imageID!) // 更换图片ID
                resultImageModelArray.add(result)
                group.leave()
            }, progressValue: { (value) in
                print(value)
            }) { (error) in
                group.leave()
            }
            index += 1
        }
        
        group.notify(queue: DispatchQueue.main) {
            let checkIds = resultImageIdArray as NSArray as! [String]
            for imageID in checkIds{
                if imageID == emtpyID{
                    failureClosure()
                    return
                }
            }
            
            let ids = resultImageIdArray.componentsJoined(by: ",")
            let images = resultImageModelArray as NSArray as! [YLUploadImageModel]
            successClosure(images,ids)
        }
        
    }
    
}

/**
 
 --音频文件上传
 */

extension YLHttpUploadManger{
    func uploadAudio(_ audioData:Data ,
                     _ parameters:[String:String],
                     _ uploadAudioURLString:String,
                     successClosure:@escaping (_ audioModel:YLUploadAudioModel) -> Void,
                     progressValue:@escaping (_ value: Double) -> Void,
                     failClosure:@escaping () -> Void) -> Void {
        //开始
        Alamofire.upload(multipartFormData: { (multipartForData) in
            multipartForData.append(audioData, withName: "audio", fileName: "file", mimeType: "audio/AMR")
        }, to: uploadAudioURLString) { (result) in
            switch result{
            case .success(let request, _, _):
                request.responseJSON(completionHandler: { (result) in
                    switch result.result{
                    case let .success(data):
                        /*
                         根据 JSON 返回格式，做好 UploadAudioModel 的 key->value 映射, 这里只是个例子
                         */
                        let model = JSONDeserializer<YLUploadAudioModel>.deserializeFrom(json: (data as! String), designatedPath: "data.data")
                        successClosure(model!)
                    case .failure(_):
                        failClosure()
                    }
                })
                request.uploadProgress(queue: DispatchQueue.global(qos: .utility), closure: { (progress) in
                    print(progress.fractionCompleted)
                    progressValue(progress.fractionCompleted)
                })
            case .failure(_):
                failClosure()
            }
        }

    }
    
}

/**
 
 --视频文件上传
 */

extension YLHttpUploadManger{
    
    
}


/**
 
 --
 */

extension YLHttpUploadManger{
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
