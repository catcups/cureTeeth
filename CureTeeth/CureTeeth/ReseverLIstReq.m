//
//  ReseverLIstReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverLIstReq.h"
#import "ReserveListModel.h"
@implementation ReseverLIstReq
- (NSString *)path {
    return @"appDoctor/appointment/index";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    [dic setObject:self.clinicName forKey:@"clinic_name"];
    [dic setObject:self.start forKey:@"start"];
    [dic setObject:self.count forKey:@"count"];
    NSString *str = [NSString stringWithFormat:@"clinic_name=%@&count=%@&doctor_id=%@&start=%@helloYya",self.clinicName,self.count,[CommonTool readUserDefaultsByKey:KDoctorId],self.start];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (![object[@"data"][@"apolist"] isKindOfClass:[NSNull class]]) {
        for (NSDictionary *dicc in object[@"data"][@"apolist"]) {
            [array addObject:[[ReserveListModel alloc]initWithDic:dicc]];
        }
    }
    return array;
}
@end
