//
//  MenuTableViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuItemCell.h"

#define imgData @[@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3"]

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

///模拟数据
-(NSArray*)simulationData{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSMutableDictionary * item;
    for (int i=0; i<imgData.count; i++) {
        item = [[NSMutableDictionary alloc] init];
        [item setObject:@"icon_" forKey:@"icon"];
        [item setObject:[NSString stringWithFormat:@"按钮%i",i] forKey:@"title"];
        [array addObject:item];
    }
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回gridView中的行数
-(NSInteger)numberOfRowInCHGGridView:(id) gridView{
    return 2;
}
//返回gridView中的列数
-(NSInteger)numberOfcolumnInRow:(id) gridView{
    return 4;
}
//返回item的view
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
    NSLog(@"data:%@",data);
    MenuItemCell * menuItemCell = [MenuItemCell initWithNibName:@"MenuItemCell"];
    menuItemCell.image.image = [UIImage imageNamed:[data objectForKey:@"icon"]];
    menuItemCell.title.text = [data objectForKey:@"title"];
    return menuItemCell;
}
//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView{
    return 90;
}

///menuItem 点击处理
-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    NSLog(@"当前点击：%li   数据：%@",position,data);
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"当前点击" message:[data objectForKey:@"title"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 210;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.menu = [[CHGMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
        _menu.items = [self simulationData];
        _menu.showPageControl = YES;//是否显示pageControll
        _menu.gridViewDatasource = self;
        _menu.gridViewDelegate = self;
        return _menu;
    }
    return nil;
}

@end
