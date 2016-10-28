//
//  MyWorkingTimeViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyWorkingTimeViewController.h"
#import "MyworkingReq.h"
#import "WorkingModel.h"
#import "ChangeWorkingReq.h"
@interface MyWorkingTimeViewController ()
@property (nonatomic,strong)NSMutableDictionary *dic1;
@property (nonatomic,strong)WorkingModel *workingModel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,assign)NSInteger acInex;
@end

@implementation MyWorkingTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的排班表";
    self.submitButton.layer.cornerRadius = 5;
    MyworkingReq *req = [[MyworkingReq alloc]init];
    [SVProgressHUD show];
    req.doctorId = [CommonTool readUserDefaultsByKey:KDoctorId];
    [req request:^(NSURLSessionDataTask *task, WorkingModel *responseObject) {
        [self handData:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)handData:(WorkingModel *)model {
    self.workingModel = model;
    NSMutableArray *titleArray = [NSMutableArray array];
    if (model.isNull) {
        return;
    }
    [titleArray addObject:model.monMorning];
    [titleArray addObject:model.monAfternoon];
    [titleArray addObject:model.tueMorning];
    [titleArray addObject:model.tueAfternoon];
    [titleArray addObject:model.wedMorning];
    [titleArray addObject:model.wedAfternoon];
    [titleArray addObject:model.thuMorning];
    [titleArray addObject:model.thuAfternoon];
    [titleArray addObject:model.friMorning];
    [titleArray addObject:model.friAfternoon];
    [titleArray addObject:model.satMorning];
    [titleArray addObject:model.satAfternoon];
    [titleArray addObject:model.sunMorning];
    [titleArray addObject:model.sunAfternoon];
    for (int i = 20; i < 34; i ++) {
        UIButton *button = [self.view viewWithTag:i];
        [button setTitle:titleArray[i - 20] forState:UIControlStateNormal];
    }
}
- (IBAction)clickButton:(UIButton *)sender {
    if (self.acInex == self.workingModel.titleArray.count) {
        self.acInex = 0;
    }
    [sender setTitle:self.workingModel.titleArray[self.acInex] forState:UIControlStateNormal];
    self.acInex ++;
}

- (IBAction)onSubmit:(id)sender {
    ChangeWorkingReq *req = [[ChangeWorkingReq alloc]init];
    for (int i = 20; i < 34; i ++) {
        UIButton *button = [self.view viewWithTag:i];
        if (i == 20) {
            req.monMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 21) {
            req.monAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 22) {
            req.tueMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 23) {
            req.tueAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 24) {
            req.wedMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 25) {
            req.wedAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 26) {
            req.thuMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 27) {
            req.thuAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 28) {
            req.friMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 29) {
            req.friAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 30) {
            req.satMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 31) {
            req.satAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 32) {
            req.sunMorning = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }   if (i == 33) {
            req.sunAfternoon = [self.workingModel.dataDic1 objectForKey:button.titleLabel.text];
        }
    }
    req.doctorId = [CommonTool readUserDefaultsByKey:KDoctorId];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1.0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"提交失败"];

    }];
}
-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
