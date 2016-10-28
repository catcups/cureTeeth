//
//  AddClinicReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AddClinicReq.h"

@implementation AddClinicReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/joinClinic";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    [dic setObject:self.code forKey:@"inviteCode"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@&inviteCode=%@helloYya",[CommonTool readUserDefaultsByKey:KDoctorId],self.code];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
