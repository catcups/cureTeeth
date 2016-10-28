//
//  AskListReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface AskListReq : DPostRequest
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *orderByTime;
@property (nonatomic,strong)NSString *orderByStatus;
@property (nonatomic,strong)NSNumber *start;
@property (nonatomic,strong)NSNumber *count;

@end
