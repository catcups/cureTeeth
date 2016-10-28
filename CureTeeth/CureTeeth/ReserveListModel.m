//
//  ReserveListModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReserveListModel.h"

@implementation ReserveListModel
- (id)initWithDic:(NSDictionary *)dic {
    ReserveListModel *model = [[ReserveListModel alloc]init];
    model.address = dic[@"address"];
    model.advisory = dic[@"advisory"];
    model.appointment = dic[@"appointment"];
    model.clinicName = dic[@"clinicName"];
    model.clinicId = dic[@"clinic_id"];
    if(![dic[@"customerName"] isKindOfClass:[NSNull class]]){
        model.customerName = dic[@"customerName"];
    }
    model.customerId = dic[@"customer_id"];
    model.doctorId = dic[@"doctor_id"];
    model.endTime = dic[@"endTime"];
    model.holdTime = dic[@"hold_time"];
    model.lastApp = dic[@"lastApp"];
    model.orderStatus =  dic[@"orderStatus"];
    model.orderTime =[StringUtils timeChange: dic[@"orderTime"]];
    model.orderId = dic[@"order_id"];
    model.photo = dic[@"photo"];
    model.time3 =[NSString stringWithFormat:@"%@至%@",dic[@"hold_time"],dic[@"endTime"]];
    model.targetDate = dic[@"targetDate"];
    model.telephone = dic[@"telephone"];
    model.timeslot = dic[@"timeslot"];
    model.wechatOpenid = dic[@"wechat_openid"];
    return model;
}
@end
