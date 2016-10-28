//
//  MyworkingReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyworkingReq.h"
#import "WorkingModel.h"
@implementation MyworkingReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/worktime";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@helloYya",self.doctorId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    if (object[@"data"]) {
        return [[WorkingModel alloc]initWithDic:object[@"data"]];
    }else {
        return nil;
    }
}
@end
