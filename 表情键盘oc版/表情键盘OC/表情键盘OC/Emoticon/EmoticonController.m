//
//  EmoticonController.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import "EmoticonController.h"
#import "EmoticonCollectionViewLayout.h"
#import "EmoticonManager.h"
#import "EmoticonPackage.h"
#import "EmoticonViewCell.h"
@interface EmoticonController ()
<UICollectionViewDelegate,UICollectionViewDataSource>
/** 工具条 */
@property(nonatomic,strong)UIToolbar *toolBar;

/** 表情collectionView */
@property(nonatomic,strong)UICollectionView *collectionView;

/** EmoticonManager */
@property(nonatomic,strong)EmoticonManager *manager;
@end

static NSString *emoticonCell = @"EmoticonCell";

@implementation EmoticonController

/** toolBar */
- (UIToolbar *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc]init];
        _toolBar.backgroundColor = [UIColor redColor];
        
        _toolBar.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        NSArray *titles = @[@"最近",@"默认",@"emoji",@"浪小花"];
        
        NSMutableArray <UIBarButtonItem *> *tempItems = [NSMutableArray array];
        //遍历标题创建item
        for (NSInteger i = 0; i<titles.count; i++) {
            NSString *title = titles[i];
            UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
            buttonItem.tag = i;
            
            [tempItems addObject:buttonItem];
            [tempItems addObject:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        }
        //3.设置toolBar的items数组
        [tempItems removeLastObject];
        _toolBar.items = tempItems;
        _toolBar.tintColor = UIColor.orangeColor;
    }
    return _toolBar;
}

- (void)itemClick:(UIBarButtonItem *)item{
    //1.获取点击的item的tag
    NSInteger tag = item.tag;
    
    //2.根据tag获取当前组
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:tag];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

/** 表情管理工具 */
- (EmoticonManager *)manager{
    if (_manager == nil) {
        _manager = [[EmoticonManager alloc]init];
    }
    return _manager;
}

/** 表情collectionView */
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        EmoticonCollectionViewLayout *layout = [[EmoticonCollectionViewLayout alloc]init];
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor purpleColor];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[EmoticonViewCell class] forCellWithReuseIdentifier:emoticonCell];
        
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}


- (instancetype)initWithEmoticonCallBack:(EmoticonCallBack)callBack{
    self = [super init];
    if (self) {
        self.block = callBack;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.collectionView];
    
//    NSArray *views = @[@{@"tBar":self.toolBar},@{@"cView":self.collectionView}];
    NSDictionary *views = @{@"tBar":self.toolBar,@"cView":self.collectionView};
//    NSArray *Hcons = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tBar]-0-|" options:kNilOptions metrics:nil views:views];
    
    NSMutableArray *cons = [NSMutableArray arrayWithArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tBar]-0-|" options:kNilOptions metrics:nil views:views]];
    [cons addObjectsFromArray:[NSMutableArray arrayWithArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cView]-0-[tBar]-0-|" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views]]];
    
    [self.view addConstraints:cons];
    
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.manager.packages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    EmoticonPackage *package = self.manager.packages[section];
    
    return package.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EmoticonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emoticonCell forIndexPath:indexPath];
    EmoticonPackage *package = self.manager.packages[indexPath.section];
    Emoticon *emoticon = package.emoticons[indexPath.item];
    cell.emoticon = emoticon;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //1.取出点击的表情
    EmoticonPackage *package = self.manager.packages[indexPath.section];
    Emoticon *emoticon = package.emoticons[indexPath.item];
    
    //2.将点击的表情插入到最近分组中
//    insertRecentlyEmoticon(emoticon: emoticon)
    [self insertRecentlyEmoticon:emoticon];
    
    //3.将表情回调给外界控制器
    self.block(emoticon);
}
- (void)insertRecentlyEmoticon:(Emoticon *)emoticon{
    if ([emoticon isEmpty] || [emoticon isRemove]) {
        return;
    }
    if ([[self.manager.packages firstObject].emoticons containsObject:emoticon] == YES) {
        NSInteger index = [[self.manager.packages firstObject].emoticons indexOfObject:emoticon];
        [[self.manager.packages firstObject].emoticons removeObjectAtIndex:index];
    }else{
        [[self.manager.packages firstObject].emoticons removeObjectAtIndex:19];

    }
    [[self.manager.packages firstObject].emoticons insertObject:emoticon atIndex:0];

}
@end
