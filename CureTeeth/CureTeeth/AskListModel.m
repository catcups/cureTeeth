//
//  AskListModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListModel.h"

@implementation AskListModel
- (id)initWithDic:(NSDictionary *)dic {
    AskListModel *model = [[AskListModel alloc]init];
    model.content = dic[@"content"];
    model.customerId = dic[@"customer_id"];
    model.mobile = dic[@"mobile"];
    model.name = dic[@"name"];
    model.photo = dic[@"photo"];
    model.photo1 = dic[@"photo1"];
    model.photo2 = dic[@"photo2"];
    model.photo3 = dic[@"photo3"];
    model.time = [StringUtils timeChange:dic[@"time"]];
    model.sex = dic[@"sex"];
    model.state = dic[@"state"];
    model.askId = dic[@"id"];
    if ([dic[@"phot1"] isKindOfClass:[NSNull class]]  && [dic[@"photo2"] isKindOfClass:[NSNull class]] && [dic[@"photo3"] isKindOfClass:[NSNull class]]) {
        model.havePhoto = @"用户未上传照片";
    }else{
        model.havePhoto = @"用户已上传照片";
    }
    return model;
}

@end
