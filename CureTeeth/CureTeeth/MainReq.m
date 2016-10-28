
//  MainReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainReq.h"

@implementation MainReq
- (NSString *)path {
    return @"appDoctor/index/index";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@helloYya",self.doctorId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

- (id)processResponse:(id)object {
    return object;
}
@end
