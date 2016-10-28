//
//  SchMangerReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SchMangerReq.h"
#import "SchMangerModel.h"
@implementation SchMangerReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/DayManagement";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    [dic setObject:self.targetDate forKey:@"targetDate"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@&targetDate=%@helloYya",[CommonTool readUserDefaultsByKey:KDoctorId],self.targetDate];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in object[@"data"]) {
        [array addObject:[[SchMangerModel alloc]initWithDic:dic]];
    }
    return array;
}
@end
