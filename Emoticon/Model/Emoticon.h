//
//  Emoticon.h
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Emoticon : NSObject
/** emoji的code */
@property(nonatomic,strong)NSString *code;
/** 普通表情对应的图片名称 */
@property(nonatomic,strong)NSString *png;
/** 普通表情对应的文字 */
@property(nonatomic,strong)NSString *chs;

@property(nonatomic,strong)NSString *pngPath;

@property(nonatomic,strong)NSString *emojiCode;

@property(nonatomic,assign)BOOL isRemove;

@property(nonatomic,assign)BOOL isEmpty;


- (instancetype)initWithDict:(NSDictionary *)dict;

- (instancetype)initWithRemove:(BOOL)isRemove;

- (instancetype)initWithEmpty:(BOOL)isEmpty;
@end

NS_ASSUME_NONNULL_END
