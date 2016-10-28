//
//  SchMangerModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/19.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SchMangerModel.h"

@implementation SchMangerModel
- (id)initWithDic:(NSDictionary *)dic{
    SchMangerModel *model = [[SchMangerModel alloc]init];
    model.customerId = dic[@"customerId"];
    if (![dic[@"cname"] isKindOfClass:[NSNull class]]) {
        model.cname = dic[@"cname"];
    }
    if (![dic[@"dname"] isKindOfClass:[NSNull class]]) {
        model.dname = dic[@"dname"];
    }
    model.doctorId = dic[@"doctor_id"];
    model.holdTime = dic[@"hold_time"];
    model.message = dic[@"message"];
    model.targetDate = dic[@"targetDate"];
    model.timeslot = dic[@"timeslot"];
    if (![dic[@"cphoto"] isKindOfClass:[NSNull class]]) {
        model.cphoto = dic[@"cphoto"];
    }else {
        model.cphoto = @"";
    }
    return model;
}
@end
