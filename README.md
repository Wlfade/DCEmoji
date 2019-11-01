# DCEmoji
自定义的一个 emoji 表情输入工具库
### 使用方法
```
导入头文件
#import "EmoticonController.h"
#import "UITextView+Extension.h"

//建立属性
//textView
@property (weak, nonatomic) IBOutlet UITextView *textView;
/** 控制器 */
@property(nonatomic,strong)EmoticonController *emoticonVC;

//懒加载
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
//弹出
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}
//打印
- (IBAction)sendAction:(id)sender {
    NSLog(@"%@", [self.textView getEmoticonString]);
}
```
