//
//  VipReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface VipReq : DPostRequest
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *offset;
@property (nonatomic,strong)NSString *limit1;
@end
