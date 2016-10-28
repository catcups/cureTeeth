//
//  SchMangerModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/19.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchMangerModel : NSObject
@property (nonatomic,strong)NSString *cname;
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *dname;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *timeslot;
@property (nonatomic,strong)NSString *cphoto;

- (id)initWithDic:(NSDictionary *)dic;

@end
