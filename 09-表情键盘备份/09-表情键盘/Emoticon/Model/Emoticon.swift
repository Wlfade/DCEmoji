//
//  Emoticon.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    //MARK:- 定义属性
    var code : String?  //emoji的code
    
    var png : String?   //普通表情对应的图片名称
    {
        didSet {
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?   //普通表情对应的文字
    
    //MARK:- 数据处理
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false
    var isEmpty : Bool = false

    //MARK:- 自定义构造函数
    init(dict:[String : String] ) {
        super.init()
        
        self.code = dict["code"]
        self.png = dict["png"]
        self.chs = dict["chs"]
        
        if self.code != nil {
            self.emojiCode = self.emojiCode(code: self.code!)
        }
        if self.png != nil {
            self.pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png!
        }
    }
    init(isRemove:Bool){
        self.isRemove = true
    }
    
    init(isEmpty:Bool){
        self.isEmpty = true
    }
}
extension Emoticon{
    func emojiCode(code:String) -> String {
        //1.创建扫描器
        let scanner = Scanner(string: code)
        //2.调用方法，扫描出code中的值
        var value : UInt32 = 0
        scanner.scanHexInt32(&value)

        //3.将value转成字符
        let c = Character(UnicodeScalar(value)!)

        //4.将字符c转成字符串
        return String(c)
    }
}
