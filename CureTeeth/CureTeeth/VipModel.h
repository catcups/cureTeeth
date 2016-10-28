//
//  VipModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipModel : NSObject
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *photo;
- (id)initWithDic:(NSDictionary *)dic;
@end
