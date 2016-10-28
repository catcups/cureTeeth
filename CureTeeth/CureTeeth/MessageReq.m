//
//  MessageReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageReq.h"
#import "MessageModel.h"
@implementation MessageReq
-(NSString *)path {
    return @"appDoctor/Message/index";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    [dic setObject:self.type forKey:@"type"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@&type=%@helloYya",[CommonTool readUserDefaultsByKey:KDoctorId],self.type];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in object[@"data"][@"message"]) {
        [array addObject:[[MessageModel alloc] initWithDic:dic]];
    }
    return array;
}
@end
