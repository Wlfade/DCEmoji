//
//  UITextView+Extension.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/23.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

extension UITextView{
    
    //获取textView属性字符串对应的表情字符串

    func getEmoticonString() -> String{
        //1.获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        //2.遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length)
        
        attrMStr.enumerateAttributes(in: range, options: []) { (dict, range, _) in
            if let attachment = dict[NSAttributedString.Key.attachment] as? EmoticonAttachment {
                attrMStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        return attrMStr.string
    }
    //给textView插入表情
    func insertEmoticon(emoticon:Emoticon){
        //1.空白表情
        if emoticon.isEmpty {
            return
        }
        
        //2.删除按钮
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        
        //3.emoji表情
        if emoticon.emojiCode != nil {
            //3.1获取光标的位置 uitextRange
            let textRange = selectedTextRange!
            
            //3.2 替换emoji 表情
            replace(textRange, withText: emoticon.emojiCode!)
            
            return
        }
        //4.普通表情：图文混排
        //4.1根据图片路径创建属性字符串
        let attachment = EmoticonAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = self.font!
        
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        //4.2创建可变的属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        //获取光标所在的位置
        let range = selectedRange
        
        //4.3将图片属性字符串替换到可变属性字符串的某一个位置
        attrMStr.replaceCharacters(in: range, with: attrImageStr)
        
        //显示属性字符串
        attributedText = attrMStr
        
        //将文字的大小重置
        self.font = font
        
        //将光标设置回原来的位置+1
        selectedRange = NSRange(location: range.location + 1, length: 0)
    }
}
