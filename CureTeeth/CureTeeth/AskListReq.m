//
//  AskListReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListReq.h"
#import "AskListModel.h"
@implementation AskListReq
- (NSString *)path {
return @"appDoctor/advisory/advisoryList";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"doctor_id"];
    [dic setObject:self.count forKey:@"count"];
    [dic setObject:self.start forKeyedSubscript:@"start"];
    if (self.clinicId) {
        [dic setObject:self.clinicId forKey:@"clinic_id"];
    }
    if (self.orderByTime) {
        [dic setObject:self.orderByTime forKey:@"orderByTime"];
    }
    if (self.orderByStatus) {
        [dic setObject:self.orderByStatus forKey:@"orderByStatus"];
    }
    NSString *str = [NSString stringWithFormat:@"clinic_id=%@&count=%@&doctor_id=%@&orderByStatus=%@&orderByTime=%@&start=%@helloYya",self.clinicId,self.count,[CommonTool readUserDefaultsByKey:KDoctorId],self.orderByStatus,self.orderByTime,self.start];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    

    return dic;
}
-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"]) {
        for (NSDictionary *dicc in object[@"data"]) {
            [array addObject:[[AskListModel alloc]initWithDic:dicc]];
        }
    }
    return array;
}
@end
