//
//  Message.m
//  WeCat
//
//  Created by  唐忠政 on 16/7/16.
//  Copyright © 2016年  唐忠政. All rights reserved.
//

#import "Message.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@implementation Message

- (instancetype)init
{
    self = [super init];
    if (self) {
       _contentFontSize = 16;
    }
    return self;
}
-(id)initWithModel:(NSDictionary *)dic {
    Message *message = [[Message alloc]init];
    if (![dic[@"cname"] isKindOfClass:[NSNull class]]) {
        message.cname = dic[@"cname"];
    }else{
        message.cname = @"";
    }
    message.content = dic[@"content"];
    message.customerId = dic[@"customer_id"];
    message.dname = dic[@"dname"];
    message.doctorsphoto = dic[@"doctorsphoto"];
    message.messageId = dic[@"id"];
    message.photo1 = dic[@"photo1"];
    message.photo2 = dic[@"photo2"];
    message.photo3 = dic[@"photo3"];
    message.time = dic[@"time"];
    if(![dic[@"userphoto"] isKindOfClass:[NSNull class]]){
        message.userPhoto = [NSURL URLWithString:dic[@"userphoto"]];
    }
    message.isSelf = NO;
    message.type = dic[@"type"];
    message.chatTime = [StringUtils timeChange: message.time];
      return  message;
}

- (id)initWithReplyModel:(NSDictionary *)dic {
    /**
     *  reply
     */
    Message *message = [[Message alloc]init];
    message.advisoryId = dic[@"advisory_id"];
    message.createTime = dic[@"create_time"];
    message.fromId = dic[@"from_id"];
    message.replyId = dic[@"id"];
    message.look = dic[@"look"];
    message.toId = dic[@"to_id"];
    message.message = dic[@"message"];
    message.isSelf = YES;
    message.type = dic[@"type"];
    message.chatTime  = [StringUtils timeChange: message.createTime];
    return  message;

}
-(void)setContent:(NSString *)content {
    if (![content isEqualToString:_content]) {
        _content = content;
        
        //2) 根据文字的内容和字体的大小进行content的frame的设置
        //a) 通过字体的大小获取相关的字体内容
        NSDictionary *arrtributeDic = @{ NSFontAttributeName : [UIFont systemFontOfSize:_contentFontSize]};
        //b) 通过获取的字体属性，计算content的frame大小
        CGRect frame = [content boundingRectWithSize:CGSizeMake(kScreenW-160, 1000)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:arrtributeDic
                                             context:nil];
        //c) 赋值_frame
        _frame = frame;
    }
    
    
}

@end
