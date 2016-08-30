//
//  TableViewCell.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "TableViewCell.h"
#import "SecondViewController.h"
//#import "MJRefresh.h"

@implementation TableViewCell

-(void)gridViewCellWillAppear{
    [super gridViewCellWillAppear];
    NSLog(@"😄");
//    if (![_tableView.mj_header isRefreshing]) {
//        [_tableView.mj_header beginRefreshing];
//    }
    
}

-(void)gridViewCellDidLoad{
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_tableView.mj_header endRefreshing];
//        });
//        
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"点单类型：%li  数据%li",_orderType,indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController * secondVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    secondVC.title = [NSString stringWithFormat:@"点单类型：%li  数据%li",_orderType,indexPath.row];
    [self.target.navigationController pushViewController:secondVC animated:YES];
}

@end
