//
//  AppDelegate.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
- (void)setWindowRootViewController:(UIViewController *)viewController WithDuration:(CGFloat)duration;
- (void)setRoot;
@property (strong, nonatomic) UIWindow *window;


@end

