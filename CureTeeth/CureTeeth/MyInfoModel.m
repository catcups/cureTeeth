//
//  MyInfoModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyInfoModel.h"

@implementation MyInfoModel
- (id)initWithDic:(NSDictionary *)dic {
    MyInfoModel *model = [[MyInfoModel alloc]init];
    model.aboutMe = dic[@"aboutMe"];
    model.mobile = dic[@"mobile"];
    model.name = dic[@"name"];
    model.photo = dic[@"photo"];
    if ([dic[@"sex"] isEqualToString:@"1"]) {
        model.sex = @"男";
    }else {
        model.sex = @"女";
    }
    return model;
}
@end
