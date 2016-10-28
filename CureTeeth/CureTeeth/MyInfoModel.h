//
//  MyInfoModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfoModel : NSObject
@property (nonatomic,strong)NSString *aboutMe;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *photo;
- (id)initWithDic:(NSDictionary *)dic;
@end
