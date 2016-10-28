//
//  ScanReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ScanReq.h"

@implementation ScanReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/Schedule_Management";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:@"D0000001" forKey:@"doctor_id"];
    [dic setObject:@"2016052353515453" forKey:@"orderId"];
//    NSString *str = [NSString stringWithFormat:@"doctor_id=D0000001&orderId=2016052353515453helloYya",self.doctorId];
    [dic setObject:[StringUtils md5FromString:@"doctor_id=D0000001&orderId=2016052353515453helloYya"] forKey:@"mdkey"];

    return dic;
}


@end
