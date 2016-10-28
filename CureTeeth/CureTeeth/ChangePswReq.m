//
//  ChangePswReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChangePswReq.h"

@implementation ChangePswReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/changepass";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    [dic setObject:self.oldpass forKey:@"oldpass"];
    [dic setObject:self.newpass forKey:@"newpass"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@&newpass=%@&oldpass=%@helloYya",self.doctorId,self.newpass,self.oldpass];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}


@end
