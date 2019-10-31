//
//  EmoticonManager.h
//  表情键盘OC
//
//  Created by 单车 on 2019/10/30.
//  Copyright © 2019 单车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmoticonPackage.h"
NS_ASSUME_NONNULL_BEGIN

@interface EmoticonManager : NSObject
/** 数组 */
@property(nonatomic,strong)NSMutableArray <EmoticonPackage *>*packages;
@end

NS_ASSUME_NONNULL_END
