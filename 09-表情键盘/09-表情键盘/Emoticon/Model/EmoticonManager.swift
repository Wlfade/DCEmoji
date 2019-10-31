//
//  EmoticonManager.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {
    var packages:[EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        //1.添加最近表情的包
        packages.append(EmoticonPackage(id: ""))
        
        //2.添加默认表情的包
        packages.append(EmoticonPackage(id: "com.sina.default"))
        
        //3.添加emoji表情的包
        packages.append(EmoticonPackage(id: "com.apple.emoji"))
        
        //4.添加浪小花表情的包
        packages.append(EmoticonPackage(id: "com.sina.lxh"))
        
    }
    
}
