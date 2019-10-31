//
//  UITextView+Extension.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/30.
//  Copyright © 2019 单车. All rights reserved.
//

#import "UITextView+Extension.h"
#import "EmoticonAttachement.h"
#import "Emoticon.h"
@implementation UITextView (Extension)
- (NSString *)getEmoticonString{
    //1.获取属性字符串
    NSMutableAttributedString *attrMStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    //2.遍历属性字符串
    NSRange range = NSMakeRange(0, attrMStr.length);
    
    //遍历获得符合指定属性或属性字典的区域(range)，并在 block 中进行设置
    [attrMStr enumerateAttributesInRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        EmoticonAttachement *attachement = attrs[@"NSAttachment"];
        if (attachement != nil) {
            [attrMStr replaceCharactersInRange:range withString:attachement.chs];
        }
    }];
    return attrMStr.string;
}

- (void)insertEmoticon:(Emoticon *)emoticon{
    if (emoticon.isEmpty == YES) {
        return;
    }
    if (emoticon.isRemove) {
        [self deleteBackward];
        return;
    }
    
    if (emoticon.emojiCode != nil) {
        UITextRange *textRange = self.selectedTextRange;
        
        [self replaceRange:textRange withText:emoticon.emojiCode];
        
        return;
    }
    //4.普通表情：图文混排
    //4.1根据图片路径创建属性字符串
    EmoticonAttachement *attachement = [[EmoticonAttachement alloc]init];
    attachement.chs = emoticon.chs;
    attachement.image = [UIImage imageWithContentsOfFile:emoticon.pngPath];
    UIFont *font = self.font;
    attachement.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
    NSAttributedString *attrImageStr = [NSAttributedString attributedStringWithAttachment:attachement];
    
    //4.2 创建可变的属性字符串
    NSMutableAttributedString *attrMStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    NSRange range = [self selectedRangeInTextView:self];
        
    [attrMStr replaceCharactersInRange:range withAttributedString:attrImageStr];
    
    self.attributedText = attrMStr;
    
    self.font = font;
    
    self.selectedRange = NSMakeRange(range.location + 1, 0);
}

- (NSRange) selectedRangeInTextView:(UITextView*)textView
{
    UITextPosition* beginning = textView.beginningOfDocument;

    UITextRange* selectedRange = textView.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;

    const NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}
@end
