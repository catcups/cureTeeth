//
//  MyInfoViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyinfoHeadTableViewCell.h"
#import "MyInfoReq.h"
#import "MyInfoModel.h"
#import "InfoDetailViewController.h"
#import "MyWorkingTimeViewController.h"
#import "ChangePassworldViewController.h"
#import "AddClinicViewController.h"
@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)MyInfoModel *model;
@end

@implementation MyInfoViewController
- (id)init {
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我的信息", nil) image:[UIImage imageNamed:@"usernor"] selectedImage:[[UIImage imageNamed:@"user_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleArray = @[@"修改密码",@"我的排班表",@"加入诊所"];
    self.title = @"我的信息";
    self.logoutButton.layer.cornerRadius = 5;
    self.tableview.tableFooterView = [[UIView alloc]init];
    MyInfoReq *req = [[MyInfoReq alloc]init];
    [SVProgressHUD show];
    req.doctorId = [CommonTool readUserDefaultsByKey:KDoctorId];
    [req request:^(NSURLSessionDataTask *task, MyInfoModel *responseObject) {
        self.model = responseObject;
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }else {
        return 44;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyinfoHeadTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyinfoHeadTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.model) {
            [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",self.model.photo]]];
            cell.userName.text = self.model.name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.phoneButton setTitle:self.model.mobile forState:UIControlStateNormal];
        }
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 15.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        InfoDetailViewController *info = [[InfoDetailViewController alloc]init];
        info.infoModel = self.model;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
           ChangePassworldViewController  *change = [[ChangePassworldViewController alloc]init];
            change.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:change animated:YES];
        }
        if (indexPath.row == 1) {
            MyWorkingTimeViewController *working = [[MyWorkingTimeViewController alloc]init];
            working.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:working animated:YES];
        }
        if (indexPath.row == 2) {
            AddClinicViewController *addClinic = [[AddClinicViewController alloc]init];
            addClinic.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addClinic animated:YES];
        }
    }
}

- (IBAction)onLoutOut:(id)sender {
    [CommonTool storeUserDefaults:nil ForKey:KKeepLogin];
    [kTHEAPP setRoot];
}

@end
