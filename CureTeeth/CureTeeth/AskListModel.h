//
//  AskListModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AskListModel : NSObject
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *askId;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *photo2;
@property (nonatomic,strong)NSString *photo1;
@property (nonatomic,strong)NSString *photo3;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *havePhoto;
@property (nonatomic,strong)NSString *time;
- (id)initWithDic:(NSDictionary *)dic;
@end
