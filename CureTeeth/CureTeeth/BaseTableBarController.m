//
//  BaseTableBarController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseTableBarController.h"
#import "MyInfoViewController.h"
#import "VipViewController.h"
#import "MainViewController.h"
#import "BaseNavViewController.h"
@implementation BaseTableBarController
- (void)viewDidLoad {
    self.tabBar.tintColor = KMainColor;
    BaseNavViewController *main = [[BaseNavViewController alloc]initWithRootViewController:[[MainViewController alloc] init]];
    BaseNavViewController *vip = [[BaseNavViewController alloc]initWithRootViewController:[[VipViewController alloc] init]];
    BaseNavViewController *info = [[BaseNavViewController alloc]initWithRootViewController:[[MyInfoViewController alloc] init]];
    self.viewControllers = @[main,vip,info];
}
@end
