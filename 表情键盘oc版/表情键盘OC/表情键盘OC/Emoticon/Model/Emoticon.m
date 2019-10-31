//
//  Emoticon.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import "Emoticon.h"

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C000) << 18) | (c & 0x3F) << 24)


@implementation Emoticon
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.code = dict[@"code"];
        self.png = dict[@"png"];
        self.chs = dict[@"chs"];
        
        if (self.code != nil) {
            self.emojiCode = [Emoticon emojiWithStringCode:self.code];
        }
        
        if (self.png != nil) {
            self.pngPath = [NSString stringWithFormat:@"%@/Emoticons.bundle/%@",NSBundle.mainBundle.bundlePath,self.png];
        }
        
    }
    return self;
}

- (instancetype)initWithRemove:(BOOL)isRemove{
    self = [super init];
    if (self) {
        self.isRemove = YES;
    }
    return self;
}

- (instancetype)initWithEmpty:(BOOL)isEmpty{
    self = [super init];
    if (self) {
        self.isEmpty = YES;
    }
    return self;
}

#pragma mark - < emoji 表情 >
/**
 将十六进制的编码转为 emoji 字符串
 
 @param intCode 无符号 32 位整数
 @return 字符串
 */
+ (NSString *)emojiWithIntCode:(unsigned int)intCode{
    unsigned int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc]initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [NSString stringWithFormat:@"%C",(unichar)intCode];
    }
    return string;
}
/**
将十六进制的编码转为 emoji 字符串

@param stringCode 十六进制格式的字符串, 例如`0x1f633`
@return 字符串
*/
+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    NSScanner *scanner = [[NSScanner alloc] initWithString:stringCode];
    
    unsigned int intCode = 0;
    
    [scanner scanHexInt:&intCode];
    
    return [self emojiWithIntCode:intCode];
}
/**
 返回当前十六进制格式字符串`0x1f633`对应的emoji字符串
 
 @return emoji 字符串
 */
//- (NSString *)emoji
//{
//    return [Emoticon emojiWithStringCode:self];
//}
@end
