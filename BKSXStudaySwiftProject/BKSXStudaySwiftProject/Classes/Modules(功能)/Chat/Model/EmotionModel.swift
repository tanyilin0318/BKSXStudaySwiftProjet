//
//  EmotionModel.swift
//  BKSXStudaySwiftProject
//
//  Created by 谭林杰 on 2018/9/13.
//  Copyright © 2018年 Bksx-cp. All rights reserved.
//

import UIKit
import HandyJSON


struct EmotionModel:HandyJSON{
    
    var imageString : String!
    var text : String!
    
    init(fromDictionary dictionary:NSDictionary) {
        let imageText = dictionary["image"] as! String
        imageString = "\(imageText)@2x"
        text = dictionary["text"] as? String
    }
    
    init() {
        
    }
    
}

