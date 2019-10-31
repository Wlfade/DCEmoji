//
//  EmoticonManager.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/30.
//  Copyright © 2019 单车. All rights reserved.
//

#import "EmoticonManager.h"

@implementation EmoticonManager

- (NSMutableArray<EmoticonPackage *> *)packages{
    if (_packages == nil) {
        _packages = [NSMutableArray array];
    }
    return _packages;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //1.添加最近表情的包
        [self.packages addObject:[[EmoticonPackage alloc]initWithId:@""]];
        
        //2.添加默认表情的包
        [self.packages addObject:[[EmoticonPackage alloc]initWithId:@"com.sina.default"]];
        
        //3.添加emoji表情的包
        [self.packages addObject:[[EmoticonPackage alloc]initWithId:@"com.apple.emoji"]];
        
        //4.添加最近表情的包
        [self.packages addObject:[[EmoticonPackage alloc]initWithId:@"com.sina.lxh"]];
    }
    return self;
}
@end
