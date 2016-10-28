//
//  MyInfoReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyInfoReq.h"
#import "MyInfoModel.h"
@implementation MyInfoReq
-(NSString *)path {
    return @"appDoctor/Personalcenter/personal";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@helloYya",self.doctorId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    if (object[@"data"][@"doctor"]) {
        return [[MyInfoModel alloc] initWithDic:object[@"data"][@"doctor"][@"0"]];
    }else{
        return nil;
    }
}
@end
