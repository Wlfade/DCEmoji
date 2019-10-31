//
//  EmoticonController.h
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

typedef void (^EmoticonCallBack)(Emoticon * _Nonnull emoticon);

NS_ASSUME_NONNULL_BEGIN
@interface EmoticonController : UIViewController

/** 回调block */
@property(nonatomic,copy)EmoticonCallBack block;

- (instancetype)initWithEmoticonCallBack:(EmoticonCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
