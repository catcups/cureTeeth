//
//  ChangeReseverStatusReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChangeReseverStatusReq.h"

@implementation ChangeReseverStatusReq
- (NSString *)path {
    return @"appDoctor/appointment/changeStatus";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    [dic setObject:self.orderId forKey:@"order_id"];
    [dic setObject:self.targetDate forKey:@"targetDate"];
    [dic setObject:self.operation forKey:@"operation"];
    [dic setObject:self.timeslot forKey:@"timeslot"];
    [dic setObject:self.holdTime forKey:@"hold_time"];
    [dic setObject:self.clinicId forKey:@"clinic_id"];
    NSString *str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@&hold_time=%@&operation=%@&order_id=%@&targetDate=%@&timeslot=%@helloYya",self.clinicId,[CommonTool readUserDefaultsByKey:KDoctorId],self.holdTime,self.operation,self.orderId,self.targetDate,self.timeslot];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}


@end
