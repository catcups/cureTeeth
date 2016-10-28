//
//  SchMangerViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SchMangerViewController.h"
#import "SchMangerReq.h"
#import "SchMangerModel.h"
#import "SchMangerTableViewCell.h"
@interface SchMangerViewController ()<UITableViewDelegate,UITableViewDataSource,LGCalendarDelegate>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)LGCalendar *LGCalendar;
@property (nonatomic,strong)NodataView *noDataView;

@end

@implementation SchMangerViewController
-(NodataView*)noDataView {
    if (!_noDataView) {
        _noDataView = [[NodataView alloc]initWithFrame:self.tableview.frame];
        _noDataView.titleLab.text = @"没有预约数据啦!";
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程管理";
    LGCalendar *calendar = [[LGCalendar alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 270)];
    [self.view addSubview:calendar];
    calendar.delegate = self;
    self.tableview.tableFooterView = [[UIView alloc]init];
    self.LGCalendar = calendar;
    [self reloadDataWithTargetDate:[StringUtils getCurrentTime]];
}

- (void)LGCalendar:(LGCalendar *)calendar didSelectDate:(NSString *)selectDate currtentYear:(NSInteger)currentYear currtentMonth:(NSInteger)currentMonth currentDay:(NSInteger)currentday{
    [self reloadDataWithTargetDate:selectDate];
}

-(void)reloadDataWithTargetDate:(NSString *)targetDate {
    [SVProgressHUD show];
    SchMangerReq *req = [[SchMangerReq alloc]init];
    req.targetDate = targetDate;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        if (self.dataSource.count == 0) {
            self.noDataView.hidden = NO;
        }else{
            self.noDataView.hidden = YES;
        }
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.noDataView.hidden = NO;
        [SVProgressHUD dismiss];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SchMangerModel *model = self.dataSource[indexPath.row];
    SchMangerTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SchMangerTableViewCell" owner:nil options:nil] lastObject];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

@end
