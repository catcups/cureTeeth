//
//  ChangeWorkingReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChangeWorkingReq.h"

@implementation ChangeWorkingReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/workChange";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.monMorning forKey:@"Mon_morning"];
    [dic setObject:self.monAfternoon forKey:@"Mon_afternoon"];
    [dic setObject:self.tueMorning forKey:@"Tue_morning"];
    [dic setObject:self.tueAfternoon forKey:@"Tue_afternoon"];
    [dic setObject:self.wedMorning forKey:@"Wed_morning"];
    [dic setObject:self.wedAfternoon forKey:@"Wed_afternoon"];
    [dic setObject:self.thuMorning forKey:@"Thu_morning"];
    [dic setObject:self.thuAfternoon forKey:@"Thu_afternoon"];
    [dic setObject:self.friMorning forKey:@"Fri_morning"];
    [dic setObject:self.friAfternoon forKey:@"Fri_afternoon"];
    [dic setObject:self.satMorning forKey:@"Sat_morning"];
    [dic setObject:self.satAfternoon forKey:@"Sat_afternoon"];
    [dic setObject:self.sunMorning forKey:@"Sun_morning"];
    [dic setObject:self.sunAfternoon forKey:@"Sun_afternoon"];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    NSString *str = [NSString stringWithFormat:@"Fri_afternoon=%@&Fri_morning=%@&Mon_afternoon=%@&Mon_morning=%@&Sat_afternoon=%@&Sat_morning=%@&Sun_afternoon=%@&Sun_morning=%@&Thu_afternoon=%@&Thu_morning=%@&Tue_afternoon=%@&Tue_morning=%@&Wed_afternoon=%@&Wed_morning=%@&doctor_id=%@helloYya",self.friAfternoon,self.friMorning,self.monAfternoon,self.monMorning,self.satAfternoon,self.satMorning,self.sunAfternoon,self.sunMorning,self.thuAfternoon,self.thuMorning,self.tueAfternoon,self.tueMorning,self.wedAfternoon,self.wedMorning,self.doctorId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
