//
//  ReseverLIstReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ReseverLIstReq : DPostRequest
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSNumber *start;
@property(nonatomic,strong)NSNumber *count;
@end
