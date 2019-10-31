//
//  EmoticonPackage.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import "EmoticonPackage.h"

@implementation EmoticonPackage

/** _emoticons */
- (NSMutableArray<Emoticon *> *)emoticons{
    if (_emoticons == nil) {
        _emoticons = [NSMutableArray array];
    }
    return _emoticons;
}

- (instancetype)initWithId:(NSString *)idString{
    self = [super init];
    if (self) {
        //最近分组
        if ([idString isEqualToString:@""]) {
            [self addEmptyEmotion:YES];
            return self;
        }
        
        //2.根据id 拼接info.plist的路径
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@/info.plist",idString] ofType:nil inDirectory:@"Emoticons.bundle"];
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        NSArray *array = dict[@"emoticons"];
        
        NSInteger index = 0;
        for (NSMutableDictionary *dict in array) {
            NSString *png = dict[@"png"];
            if (png != nil) {
                [dict setValue:[NSString stringWithFormat:@"%@/%@",idString,png] forKey:@"png"];
            }
            [self.emoticons addObject:[[Emoticon alloc]initWithDict:dict]];
            index += 1;
            
            if (index == 20) {
                [self.emoticons addObject:[[Emoticon alloc]initWithRemove:YES]];
                
                //添加删除表情
                index = 0;
            }
        }
        [self addEmptyEmotion:NO];
    }
    return self;
}


/// 添加空的表情
/// @param isRecently 是否为最近
- (void)addEmptyEmotion:(BOOL)isRecently{
    NSInteger count = self.emoticons.count % 21;
    if (count == 0 && isRecently == NO) {
        return;
    }
    for (NSInteger i = count; i < 20; i ++) {
        [self.emoticons addObject:[[Emoticon alloc]initWithEmpty:YES]];
    }
    [self.emoticons addObject:[[Emoticon alloc]initWithRemove:YES]];
}
@end
