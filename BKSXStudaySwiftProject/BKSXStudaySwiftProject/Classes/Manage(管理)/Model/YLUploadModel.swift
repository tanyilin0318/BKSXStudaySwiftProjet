//
//  YLUploadModel.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/19.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import Foundation
import HandyJSON
import UIKit



struct YLUploadImageModel :HandyJSON {
    
    var originalURL : String?
    var originalHeight : CGFloat?
    var originalWidth : CGFloat?
    var thumbURL : String?
    var thumbHeight : CGFloat?
    var thumbWidth : CGFloat?
    var imageId : Int?
    
}

struct YLUploadAudioModel:HandyJSON {
    var audioId : String?
    var duration : Int?
    var audioURL : String?
    var fileSize : Int?
    var keyHash : String?
    var recordTime : String?
}

struct YLUploadVideoModel:HandyJSON {
    var videoId : String?
    var duration : Int?
    var videoURL : String?
    var fileSize : Int?
    var keyHash : String?
    var recordTime : String?
}
