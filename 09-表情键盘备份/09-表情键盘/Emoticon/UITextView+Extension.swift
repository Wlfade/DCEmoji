//
//  UITextView+Extension.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/23.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

extension UITextView{
//    func insertEmoticon(emoticon:Emoticon){
//        //1.空白表情
//        if emoticon.isEmpty {
//            return
//        }
//        
//        //2.删除按钮
//        if emoticon.isRemove {
//            textView.deleteBackward()
//            return
//        }
//        
//        //3.emoji表情
//        if emoticon.emojiCode != nil {
//            //3.1获取光标的位置 uitextRange
//            let textRange = textView.selectedTextRange!
//            
//            //3.2 替换emoji 表情
//            textView.replace(textRange, withText: emoticon.emojiCode!)
//            
//            return
//        }
//        //4.普通表情：图文混排
//        //4.1根据图片路径创建属性字符串
//        let attachment = EmoticonAttachment()
//        attachment.chs = emoticon.chs
//        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
//        let font = textView.font!
//        
//        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
//        let attrImageStr = NSAttributedString(attachment: attachment)
//        
//        //4.2创建可变的属性字符串
//        let attrMStr = NSMutableAttributedString(attributedString: textView.attributedText)
//        
//        //获取光标所在的位置
//        let range = textView.selectedRange
//        
//        //4.3将图片属性字符串替换到可变属性字符串的某一个位置
//        attrMStr.replaceCharacters(in: range, with: attrImageStr)
//        
//        //显示属性字符串
//        textView.attributedText = attrMStr
//        
//        //将文字的大小重置
//        textView.font = font
//        
//        //将光标设置回原来的位置+1
//        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
//    }
}
