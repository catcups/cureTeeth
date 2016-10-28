//
//  ReplyReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/26.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReplyReq.h"

@implementation ReplyReq
- (NSString *)path {
    return @"appDoctor/advisory/saveAdvisorymessage";
}

-(NSMutableDictionary *)params{
    NSMutableDictionary *dic = [super params];
    if (self.advisoryId) {
        [dic setObject:self.advisoryId forKey:@"advisory_id"];
    }
    if (self.message) {
        [dic setObject:self.message forKey:@"message"];
    }
    if (self.fromId) {
        [dic setObject:self.fromId forKey:@"from_id"];
    }
    if (self.type) {
        [dic setObject:self.type forKey:@"type"];
    }
    if (self.toId) {
        [dic setObject:self.toId forKey:@"to_id"];
    }
    NSString *str = [NSString stringWithFormat:@"advisory_id=%@&from_id=%@&message=%@&to_id=%@&type=%@helloYya",self.advisoryId,self.fromId,self.message,self.toId,self.type];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
