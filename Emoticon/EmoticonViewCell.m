//
//  EmoticonViewCell.m
//  表情键盘OC
//
//  Created by 单车 on 2019/10/30.
//  Copyright © 2019 单车. All rights reserved.
//

#import "EmoticonViewCell.h"

@interface EmoticonViewCell ()

/** emoticonBtn */
@property(nonatomic,strong)UIButton *emotionBtn;

@end

@implementation EmoticonViewCell

/** emoticonbtn */
- (UIButton *)emotionBtn{
    if (_emotionBtn == nil) {
        _emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _emotionBtn.frame = self.contentView.bounds;
        _emotionBtn.userInteractionEnabled = false;
        _emotionBtn.titleLabel.font = [UIFont systemFontOfSize:32];
        
    }
    return _emotionBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
    [self.contentView addSubview:self.emotionBtn];
    
}
- (void)setEmoticon:(Emoticon *)emoticon{
    _emoticon = emoticon;
    
    [_emotionBtn setImage:[UIImage imageWithContentsOfFile:emoticon.pngPath ? emoticon.pngPath : @""] forState:UIControlStateNormal];
    [_emotionBtn setTitle:emoticon.emojiCode forState:UIControlStateNormal];
    
    if (emoticon.isRemove == YES) {
        [_emotionBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }
    if (emoticon.isEmpty == YES) {
        
    }
    
}
@end
