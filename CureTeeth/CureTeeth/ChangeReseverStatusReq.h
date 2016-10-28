//
//  ChangeReseverStatusReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ChangeReseverStatusReq : DPostRequest
@property (nonatomic,strong)NSString *operation;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *doctorId;

@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *timeslot;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *clinicId;

@end
