//
//  EmoticonPackage.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emoticons : [Emoticon] = [Emoticon]()
    
    init(id : String) {
        super.init()
        //1.最近分组
        if id == ""{
            addEmptyEmotion(isRecently: true)
            return
        }
        //2.根据id拼接info.plist的路径
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        let dict = NSDictionary(contentsOfFile: plistPath)!

        //3.根据plist文件路径读取数据 [[String:String]]
//        let array = NSArray(contentsOfFile: plistPath)! as! [[String:String]]
        
        let array = dict["emoticons"] as! [[String:String]]

        //4.遍历数组
        var index = 0
        
        for var dict in array {
            if let png = dict["png"]{
                dict["png"] = id + "/" + png
            }
            emoticons.append(Emoticon(dict: dict))
            index += 1
            
            if index == 20 {
                emoticons.append(Emoticon(isRemove: true))
                
                //添加删除表情
                index = 0
            }
        }
        
        //5.添加空白表情
        addEmptyEmotion(isRecently: false)
    }
    private func addEmptyEmotion(isRecently:Bool){
        let count = emoticons.count % 21
        if count == 0 && !isRecently{
            return
        }
        for _ in count..<20 {
            emoticons.append(Emoticon(isEmpty: true))
        }
        emoticons.append(Emoticon(isRemove: true))
        
    }
}
