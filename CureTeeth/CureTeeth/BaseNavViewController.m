//
//  BaseNavViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTranslucent:NO];
    self.navigationBar.barTintColor = KMainColor;
    if (KENABLE_POPGESTURE)
    {
        _popGesture = [[PopGestureRecognizer alloc] initWithWrap:self];
    }
}

- (void)enableGesturePop:(BOOL)enable
{
    [_popGesture enablePanGuesture:enable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    [MaskWindow hide];
    if (KENABLE_POPGESTURE)
        [_popGesture pushViewController:viewController animated:animated];
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
//    [MaskWindow hide];
    if (KENABLE_POPGESTURE)
        [_popGesture popViewControllerAnimated:animated];
    return [super popViewControllerAnimated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
