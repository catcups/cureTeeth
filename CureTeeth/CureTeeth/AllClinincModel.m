//
//  AllClinincModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AllClinincModel.h"

@implementation AllClinincModel
- (id)initWithDic:(NSDictionary *)dic {
    AllClinincModel *model = [[AllClinincModel alloc]init];
    model.name =dic[@"name"];
    model.clinincId =dic[@"id"];
    return model;
}
@end
