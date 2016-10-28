//
//  VipViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "VipViewController.h"
#import "VipReq.h"
#import "VipModel.h"
#import "VipTableViewCell.h"
@interface VipViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation VipViewController
- (id)init {
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"会员", nil) image:[UIImage imageNamed:@"vipNormal"] selectedImage:[[UIImage imageNamed:@"vipSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员";
    // Do any additional setup after loading the view from its nib.
    VipReq *req = [[VipReq alloc]init];
    req.offset = @"20";
    req.limit1 = @"1";
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.tableFooterView = [[UIView alloc] init];
    [SVProgressHUD show];
    req.doctorId = [CommonTool readUserDefaultsByKey:KDoctorId];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = responseObject;
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VipModel *model = self.dataSource[indexPath.row];
    VipTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"VipTableViewCell" owner:nil options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
@end
