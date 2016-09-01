//
//  TableViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "TableViewController.h"
#import "CHGNavigationViewController.h"
#import "AdModeTableViewController.h"
#import "MenuTableViewController.h"
#import "Tab1ViewController.h"
#import "MemoryTestViewController.h"
#import "Tab2TestViewController.h"

#define funcs @[@"应用启动导航",@"广告轮播模式",@"菜单模式",@"tab1",@"tab2",@"其它用法"]

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sample";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return funcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = funcs[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CHGNavigationViewController * navigationModeVC = [[CHGNavigationViewController alloc] initWithNibName:@"CHGNavigationViewController" bundle:nil];
        navigationModeVC.title = funcs[indexPath.row];
        [self.navigationController pushViewController:navigationModeVC animated:YES];
    } else if(indexPath.row == 1){
        AdModeTableViewController * adModeVC = [[AdModeTableViewController alloc] initWithNibName:@"AdModeTableViewController" bundle:nil];
        adModeVC.title = funcs[indexPath.row];
        [self.navigationController pushViewController:adModeVC animated:YES];
    } else if(indexPath.row == 2){
        MenuTableViewController * menuVC = [[MenuTableViewController alloc] initWithNibName:@"MenuTableViewController" bundle:nil];
        menuVC.title = funcs[indexPath.row];
        [self.navigationController pushViewController:menuVC animated:YES];
    } else if(indexPath.row == 3){
        Tab1ViewController * tab1VC = [[Tab1ViewController alloc] initWithNibName:@"Tab1ViewController" bundle:nil];
        tab1VC.title = funcs[indexPath.row];
        [self.navigationController pushViewController:tab1VC animated:YES];
    } else if(indexPath.row == 4){
        Tab1ViewController * tab1VC = [[Tab1ViewController alloc] initWithNibName:@"Tab1ViewController" bundle:nil];
        tab1VC.title = funcs[indexPath.row];
        tab1VC.userVCMode = YES;
        [self.navigationController pushViewController:tab1VC animated:YES];
    } else if(indexPath.row == 5){
        Tab2TestViewController * tab2TestVC = [[Tab2TestViewController alloc] init];
        [self.navigationController pushViewController:tab2TestVC animated:YES];
    }
}

@end
