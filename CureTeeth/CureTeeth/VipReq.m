//
//  VipReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "VipReq.h"
#import "VipModel.h"

@implementation VipReq
-(NSString *)path {
    return @"appDoctor/vip/doctorVip";
}
-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.offset) {
        [dic setObject:self.offset forKey:@"count"];
    }
    if (self.limit1) {
        [dic setObject:self.limit1 forKey:@"start"];
    }
    if (self.doctorId) {
        [dic setObject:self.doctorId forKey:@"doctor_id"];
    }
    NSString *str = [NSString stringWithFormat:@"count=%@&doctor_id=%@&start=%@helloYya",self.offset,self.doctorId,self.limit1];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}
-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dicc in object[@"data"][@"list"]) {
        [array addObject:[[VipModel alloc] initWithDic:dicc]];
    }
    return array;
}
@end
