//
//  MessageCell.m
//  WeCat
//
//  Created by  唐忠政 on 16/7/16.
//  Copyright © 2016年  唐忠政. All rights reserved.
//

#import "MessageCell.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface MessageCell(){
    UIImageView *_imageView;
    UILabel *_label;
    UIImageView *_BgView;
    UILabel *_timeLabel;
    UILabel *_contentLB;
    UIImageView *_contentImageView;
}
@end

@implementation MessageCell
-(instancetype)init {
    self = [super init];
    [self createUI];
    return self;
}
- (void)createUI {
    
}

-(void)setMessage:(Message *)message  {
    _BgView = [[UIImageView alloc] init];
    _timeLabel = [[UILabel alloc]init];
    _imageView = [[UIImageView alloc] init];
    _label = [[UILabel alloc] init];
    _contentLB = [[UILabel alloc]init];
    _timeLabel.text = message.chatTime;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _message = message;
    _imageView.layer.cornerRadius = 5;
    _imageView.layer.masksToBounds = YES;
    _label.frame = CGRectZero;
    _label.backgroundColor = [UIColor clearColor];
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentLeft;
    _label.font = [UIFont systemFontOfSize:_message.contentFontSize];
    if ([message.type isEqualToString:@"0"]) {
        if (message.isSelf) {
            _label.text = message.message;
            [_imageView setImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KDoctorHeaderImage]]];
            _imageView.frame = CGRectMake(kScreenW-20-50+10, 45, 50, 50);
            _BgView.image = [UIImage imageNamed:@"chatto_bg_normal"];
            _BgView.image = [_BgView.image stretchableImageWithLeftCapWidth:31 topCapHeight:31];
            _BgView.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35, kEdgeSize+40, _message.frame.size.width+35, _message.frame.size.height+25);
            //3) 设置messageLabel的frame
            _timeLabel.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35, kEdgeSize*2+5, kScreenW/2, 21);
            _label.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-20, kEdgeSize*2+40, _message.frame.size.width, _message.frame.size.height);
            
        }else{
            _label.text = message.content;
            [_imageView sd_setImageWithURL:message.userPhoto];
            _imageView.frame = CGRectMake(10, 45, 50, 50);
            _BgView.frame = CGRectMake(70, 41, message.frame.size.width+40, message.frame.size.height+35);
            _BgView.image = [UIImage imageNamed:@"chatfrom_bg_normal"];
            _BgView.image = [_BgView.image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            _BgView.frame = CGRectMake(kHeadImageSize+kEdgeSize*2, kEdgeSize+40, _message.frame.size.width+35, _message.frame.size.height+25);
            //6) 设置messageLabel的frame
            _timeLabel.frame = CGRectMake(kHeadImageSize+kEdgeSize*2, kEdgeSize*2+5, kScreenW/2, 21);
            _label.frame = CGRectMake(kHeadImageSize+kEdgeSize*2+20, kEdgeSize*2+40, _message.frame.size.width, _message.frame.size.height);
        }
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_BgView];
        [self.contentView addSubview:_label];
        [self setNeedsLayout];
    }else{
        _contentImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar"]];
        _message.content = @"点击图片进行预约";
        _label.text = _message.content;
        [_imageView setImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KDoctorHeaderImage]]];
        _imageView.frame = CGRectMake(kScreenW-20-50+10, 45, 50, 50);
        _BgView.image = [UIImage imageNamed:@"chatto_bg_normal"];
        _BgView.image = [_BgView.image stretchableImageWithLeftCapWidth:31 topCapHeight:31];
        _BgView.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35 - 36, kEdgeSize+40, _message.frame.size.width+35 + 36, _message.frame.size.height+25);
        //3) 设置messageLabel的frame
        _label.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-20 - 36, kEdgeSize*2+40, _message.frame.size.width, _message.frame.size.height);
        _contentImageView.frame = CGRectMake(CGRectGetMaxX(_label.frame)+ 8, _BgView.frame.origin.y + 4, 30, 30);
        _timeLabel.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35, kEdgeSize*2+5, kScreenW/2, 21);
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_BgView];
        [self.contentView addSubview:_label];
        [self.contentView addSubview:_contentImageView];

        [self setNeedsLayout];
    }
}

@end
