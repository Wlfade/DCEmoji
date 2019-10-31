//
//  UITextView+Extension.h
//  表情键盘OC
//
//  Created by 单车 on 2019/10/30.
//  Copyright © 2019 单车. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Extension)

- (NSString *)getEmoticonString;

- (void)insertEmoticon:(Emoticon *)emoticon;
@end

NS_ASSUME_NONNULL_END
