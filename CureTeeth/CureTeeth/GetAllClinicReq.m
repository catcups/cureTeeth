//
//  GetAllClinicReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "GetAllClinicReq.h"
#import "AllClinincModel.h"
@implementation GetAllClinicReq
- (NSString*)path {
    return @"appDoctor/index/getClinicsByDoctor";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@helloYya",[CommonTool readUserDefaultsByKey:KDoctorId]];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"][@"data"]) {
        for (NSDictionary *dicc in object[@"data"][@"data"]) {
            [array addObject:[[AllClinincModel alloc]initWithDic:dicc]];
        }
    }
    return array;
}
@end
