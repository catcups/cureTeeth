//
//  WorkingModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkingModel : NSObject
@property (nonatomic,strong)NSString *monMorning;
@property (nonatomic,strong)NSString *monAfternoon;
@property (nonatomic,strong)NSString *tueMorning;
@property (nonatomic,strong)NSString *tueAfternoon;
@property (nonatomic,strong)NSString *wedMorning;
@property (nonatomic,strong)NSString *wedAfternoon;
@property (nonatomic,strong)NSString *thuMorning;
@property (nonatomic,strong)NSString *thuAfternoon;
@property (nonatomic,strong)NSString *friMorning;
@property (nonatomic,strong)NSString *friAfternoon;
@property (nonatomic,strong)NSString *satMorning;
@property (nonatomic,strong)NSString *satAfternoon;
@property (nonatomic,strong)NSString *sunMorning;
@property (nonatomic,strong)NSString *sunAfternoon;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic,strong)NSMutableDictionary *dataDic1;
@property(nonatomic,assign)BOOL isNull;
@property (nonatomic,strong)NSMutableArray *titleArray;
- (id)initWithDic:(NSDictionary *)dic;
@end
