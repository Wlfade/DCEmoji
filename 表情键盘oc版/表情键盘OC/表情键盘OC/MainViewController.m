//
//  MainViewController.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/29.
//  Copyright © 2019 单车. All rights reserved.
//

#import "MainViewController.h"
#import "EmoticonController.h" //表情控制器
#import "UITextView+Extension.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

/** 控制器 */
@property(nonatomic,strong)EmoticonController *emoticonVC;
@end

@implementation MainViewController

/** 表情 */
- (EmoticonController *)emoticonVC{
    if (_emoticonVC == nil) {
//        _emoticonVC = [[EmoticonController alloc]init];
        _emoticonVC = [[EmoticonController alloc]initWithEmoticonCallBack:^(Emoticon * _Nonnull emoticon) {
            [self.textView insertEmoticon:emoticon];
        }];
    }
    return _emoticonVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.inputView = self.emoticonVC.view;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}
- (IBAction)sendAction {
    NSLog(@"%@", [self.textView getEmoticonString]);
}
@end
