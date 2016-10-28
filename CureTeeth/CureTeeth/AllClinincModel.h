//
//  AllClinincModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllClinincModel : NSObject
@property (nonatomic,strong)NSString *clinincId;
@property (nonatomic,strong)NSString *name;
- (id)initWithDic:(NSDictionary *)dic;

@end
