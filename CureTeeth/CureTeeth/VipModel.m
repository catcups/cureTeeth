//
//  VipModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "VipModel.h"

@implementation VipModel
- (id)initWithDic:(NSDictionary *)dic {
    VipModel *model = [[VipModel alloc]init];
    model.customerId = dic[@"customer_id"];
    model.mobile = dic[@"mobile"];
    model.name = dic[@"name"];
    model.nickname = dic[@"nickname"];
    model.photo = dic[@"photo"];
    return model;
}
@end
