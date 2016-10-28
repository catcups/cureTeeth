//
//  WorkingModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "WorkingModel.h"

@implementation WorkingModel
- (id)initWithDic:(NSDictionary *)dic {
    if ( dic[@"clinic"] == nil) {
        return nil;
    }
    WorkingModel *model = [[WorkingModel alloc]init];
    model.titleArray = [NSMutableArray array];
    model.dataDic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    for (NSDictionary *dicc in dic[@"clinic"]) {
        [dic1 setObject:dicc[@"clinic_name"] forKey:dicc[@"clinic_id"]];
        [model.dataDic1 setObject:dicc[@"clinic_id"] forKey:dicc[@"clinic_name"]];
        [model.titleArray addObject:dicc[@"clinic_name"]];
    }
    [model.titleArray addObject:@"休息"];
    [model.dataDic1 setObject:@"0"forKey:@"休息"];
    model.dataDic = dic1;
    if(![dic[@"workTime"] isKindOfClass:[NSNull class]]){
        model.monMorning = ((NSString *)(dic[@"workTime"][@"Mon_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Mon_morning"]];
        model.monAfternoon = ((NSString *)(dic[@"workTime"][@"Mon_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Mon_afternoon"]];
        
        model.tueMorning = ((NSString *)(dic[@"workTime"][@"Tue_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Tue_morning"]];
        model.tueAfternoon = ((NSString *)(dic[@"workTime"][@"Tue_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Tue_afternoon"]];
        
        model.wedMorning = ((NSString *)(dic[@"workTime"][@"Wed_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Wed_morning"]];
        model.wedAfternoon = ((NSString *)(dic[@"workTime"][@"Wed_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Wed_afternoon"]];
        
        model.thuMorning = ((NSString *)(dic[@"workTime"][@"Thu_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Thu_morning"]];
        model.thuAfternoon = ((NSString *)(dic[@"workTime"][@"Thu_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Thu_afternoon"]];
        
        model.friAfternoon = ((NSString *)(dic[@"workTime"][@"Fri_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Fri_afternoon"]];
        model.friMorning = ((NSString *)(dic[@"workTime"][@"Fri_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Fri_morning"]];
        
        model.satMorning = ((NSString *)(dic[@"workTime"][@"Sat_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Sat_morning"]];
        model.satAfternoon = ((NSString *)(dic[@"workTime"][@"Sat_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Sat_afternoon"]];
        
        model.sunMorning = ((NSString *)(dic[@"workTime"][@"Sun_morning"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Sun_morning"]];
        model.sunAfternoon = ((NSString *)(dic[@"workTime"][@"Sun_afternoon"])).length == 0 ? @"休息":[dic1 objectForKey:dic[@"workTime"][@"Sun_afternoon"]];

    }else{
        model.isNull = YES;
    }
       return model;
}


@end
