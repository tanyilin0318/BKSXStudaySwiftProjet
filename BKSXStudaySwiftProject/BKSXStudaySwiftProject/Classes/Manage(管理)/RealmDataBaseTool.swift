//
//  RealmDataBaseTool.swift
//  LearnRealm
//
//  Created by 谭林杰 on 2019/1/30.
//  Copyright © 2019 Bksx-cp. All rights reserved.
//

import UIKit
import RealmSwift



class RealmDataBaseTool: NSObject {

    //配置数据库

    public class func congfigRealm() -> Void {
        let DBVersion : UInt64 = 3
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath + "/DefalutDB.realm"
        let congfig = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: DBVersion, migrationBlock: { (Migration, oldDbVesion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
//        let realm = try! Realm.init(configuration: congfig)
        Realm.Configuration.defaultConfiguration = congfig
        Realm.asyncOpen { (realm, error) in
            if let _ = realm{
                print("Realm 数据库配置成功")
            }else if let error = error{
                print("Realm 失败 ：\(error)")
            }
        }
        
    }
}

/**
 打开相册或相机
 */
import UIKit
import AVFoundation
import Photos
import MobileCoreServices

class LYBOpenAblumOrCameraVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var  pickImageController:UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPhotoOrCamera(index: 0)
        
    }
    //选择相册、拍照、录像
    func selectPhotoOrCamera(index:Int){
        switch index {
        case 0://相册
            openAblum()
            break
        case 1://拍照
            openCamera(index: 1)
            break
        case 2://录像
            openCamera(index: 2)
            break
        default: break
            
        }
    }
    //打开相册
    func openAblum(){
        weak var weakSelf=self
        
        pickImageController=UIImagePickerController.init()
        //savedPhotosAlbum是根据日期排列，photoLibrary是所有相册
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            //获取相册权限
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .notDetermined: break
                    
                case .restricted://此应用程序没有被授权访问的照片数据
                    break
                case .denied://用户已经明确否认了这一照片数据的应用程序访问
                    break
                case .authorized://已经有权限
                    weakSelf!.pickImageController!.delegate=self
                    weakSelf!.pickImageController!.allowsEditing = true
                    weakSelf!.pickImageController!.sourceType = UIImagePickerController.SourceType.photoLibrary;
                    //                    weakSelf?.pickImageController?.mediaTypes=[kUTTypeMovie as String]//只有视频
                    //                 weakSelf?.pickImageController?.mediaTypes=[kUTTypeImage as String]//只有照片
                    weakSelf?.pickImageController?.mediaTypes=UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//包括照片和视频
                    //弹出相册页面或相机
                    self.present( weakSelf!.pickImageController!, animated: true, completion: {
                    })
                    
                    break
                }
            })
            
        }
        
        
    }
    //打开相机拍照或者录像
    func openCamera(index:Int){
        weak var weakSelf=self
        pickImageController=UIImagePickerController.init()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (ist) in
                //检查相机权限
                let status:AVAuthorizationStatus=AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                if status==AVAuthorizationStatus.authorized {// 有相机权限
                    
                    //跳转到相机或者相册
                    weakSelf!.pickImageController!.delegate=self
                    weakSelf!.pickImageController!.allowsEditing = true
                    self.pickImageController!.sourceType = UIImagePickerController.SourceType.camera;
                    
                    if index==1{//拍照
                        weakSelf?.pickImageController?.mediaTypes=[kUTTypeImage as String]//拍照
                        
                    }else if index==2{
                        weakSelf?.pickImageController?.mediaTypes=[kUTTypeMovie as String]//录像
                    }else {
                        weakSelf?.pickImageController?.mediaTypes=UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//拍照和录像都可以
                    }
                    //弹出相册页面或相机
                    self.present(self.pickImageController!, animated: true, completion: {
                        
                    })
                }else if (status==AVAuthorizationStatus.denied)||(status==AVAuthorizationStatus.restricted) {
                    
                }else if(status==AVAuthorizationStatus.notDetermined){//权限没有被允许
                    //去请求权限
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { (genter) in
                        if (genter){
                            print("去打开相机")
                        }else{
                            print(">>>访问受限")
                        }
                    }
                }
            })
        }
    }
    //去设置权限
    @available(iOS 10.0, *)
    func gotoSetting(){
        let alertController:UIAlertController=UIAlertController.init(title: "去设置", message: "设置-》通用-》", preferredStyle: UIAlertController.Style.alert)
        
        let sure:UIAlertAction=UIAlertAction.init(title: "去开启权限", style: UIAlertAction.Style.default) { (ac) in
            let url=URL.init(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!){
                
                UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                    
                    
                    UIApplication.shared.openURL(url!)
                    
                })
            }
        }
        alertController.addAction(sure)
        self.present(alertController, animated: true) {
            
        }
    }
    
    //    要将MobileCoreServices 框架添加到项目中,导入：#import <MobileCoreServices/MobileCoreServices.h> 。不然后出现错误使用未声明的标识符 'kUTTypeMovie'
    //    swift 中import MobileCoreServices
    
    //选中图片，保存图片或视频到系统相册
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        //取消选择
        picker.dismiss(animated: true) {
            
        }
        var image: UIImage?
        print("\(info)")
        /**
         info打印出来的值
         [__C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerMediaType): public.image, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerCropRect): NSRect: {{0, 0}, {750, 558}}, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerEditedImage): <UIImage: 0x281232ae0> size {750, 558} orientation 0 scale 1.000000, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerOriginalImage): <UIImage: 0x28122dd50> size {750, 557} orientation 0 scale 1.000000, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerPHAsset): <PHAsset: 0x14be77900> 25183429-BD2B-4C3B-A850-1161B45F21CB/L0/001 mediaType=1/4, sourceType=1, (750x557), creationDate=2018-12-19 06:57:17 +0000, location=0, hidden=0, favorite=0 , __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerReferenceURL): assets-library://asset/asset.JPG?id=25183429-BD2B-4C3B-A850-1161B45F21CB&ext=JPG, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerImageURL): file:///private/var/mobile/Containers/Data/Application/9D23C5AB-8CA2-4BA1-ADFB-1CDF0251F9A4/tmp/9E4D6A79-8EA2-4EF4-96AA-B65E0F497B11.jpeg]
         */
        
        
        let typ:String = (info[UIImagePickerController.InfoKey.mediaType]as!String)//类型
        // 图片类型"public.image"
        if typ == "public.image"{
            if(picker.allowsEditing){
                //裁剪后图片
                image=(info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
            }else{
                //原始图片
                image=(info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
            }
            
            //缩小图片
            let newSize=CGSize.init(width: 100, height: 100)
            UIGraphicsBeginImageContext(newSize)
            
            image!.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext();
            //        这个是系统的方法，先来解释下各个参数:
            //        1.image:将要保存的图片
            //        2.completionTarget:保存完毕后，回调方法所在的对象
            //        3.completionSelector:保存完毕后，回调的方法
            //        4.contextInfo:可选参数
            UIImageWriteToSavedPhotosAlbum(newImage, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
            
        }else if typ == "public.movie"{
            //视频类型
            let url = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL//视频的url
            let urlStr = url.path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr!){
                //保存视频到相簿，
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string:urlStr!)!)
                }) { (boo, error) in
                    if boo{
                        print("保存视频成功")
                    }
                    
                }
            }
            
            
        }
        
    }
    //保存到系统相册
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        print("保存相册成功")
    }
}

