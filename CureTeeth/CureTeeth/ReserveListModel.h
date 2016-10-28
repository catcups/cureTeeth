//
//  ReserveListModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReserveListModel : NSObject
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *advisory;
@property (nonatomic,strong)NSString *appointment;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *customerName;
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *lastApp;
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *orderTime;

@property (nonatomic,strong)NSString *time3;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *telephone;
@property (nonatomic,strong)NSString *timeslot;
@property (nonatomic,strong)NSString *wechatOpenid;
@property (nonatomic,assign)NSInteger indexPathRow;

- (id)initWithDic:(NSDictionary *)dic;

@end
