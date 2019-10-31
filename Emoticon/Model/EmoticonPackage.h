//
//  EmoticonPackage.h
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Emoticon.h"
NS_ASSUME_NONNULL_BEGIN

@interface EmoticonPackage : NSObject
/** emoticons数组 */
@property(nonatomic,strong)NSMutableArray<Emoticon *> *emoticons;


- (instancetype)initWithId:(NSString *)idString;
@end

NS_ASSUME_NONNULL_END
