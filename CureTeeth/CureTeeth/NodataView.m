//
//  NodataView.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "NodataView.h"

@implementation NodataView
- (id)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,100 , CGRectGetWidth(frame), 20)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.text = @"没有筛选结果!";
        [self addSubview:self.titleLab];
    }
    return self;
}
@end
