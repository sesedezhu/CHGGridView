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

-(void)gridViewCellDidDisappear{
    [super gridViewCellDidDisappear];
    NSLog(@"gridViewCellDidDisappear:%li",self.tag);
}

-(void)gridViewCellDidLoad{
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
