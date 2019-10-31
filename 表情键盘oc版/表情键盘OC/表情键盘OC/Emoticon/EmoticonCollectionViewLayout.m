//
//  EmoticonCollectionViewLayout.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import "EmoticonCollectionViewLayout.h"

@implementation EmoticonCollectionViewLayout
- (void)prepareLayout{
    [super prepareLayout];
    
    CGFloat itemWH = UIScreen.mainScreen.bounds.size.width / 7;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    self.minimumLineSpacing = 0;
    
    self.minimumInteritemSpacing = 0;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    CGFloat insetMargin = (self.collectionView.bounds.size.height - 3*itemWH)/2;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0);
}

@end
