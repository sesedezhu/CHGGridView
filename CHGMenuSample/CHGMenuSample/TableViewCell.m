//
//  TableViewCell.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "TableViewCell.h"
#import "SecondViewController.h"
#import "MJRefresh.h"

@implementation TableViewCell

-(void)gridViewCellDidLoad{
    [super gridViewCellDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _curryPage = 1;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        _curryPage = 1;
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _curryPage += 1;
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
    }];
}

-(void)gridViewCellWillAppear{
    [super gridViewCellWillAppear];
    NSLog(@"页面从新出现");
    [_tableView.mj_header beginRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20*_curryPage;
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
