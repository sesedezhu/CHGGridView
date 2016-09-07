//
//  AdModeTableViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "AdModeTableViewController.h"
#import "AdCell.h"
#import "Tab1ViewController.h"

@interface AdModeTableViewController ()

@end

@implementation AdModeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

///构造返回的view  需要继承CHGGridViewCell类
-(CHGGridViewCell*)adView:(id)adView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
    AdCell * cell = (AdCell*)[((CHGAdView*)adView).chgMenu.gridView dequeueReusableCellWithIdentifier:@"AdCell" withPosition:position];
    cell.image.image = [UIImage imageNamed:[data objectForKey:@"icon"]];
    return cell;
}

///CHGGridViewCell被点击时候回调
-(void)adView:(id)adView didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    Tab1ViewController * a = [[Tab1ViewController alloc] initWithNibName:@"Tab1ViewController" bundle:nil];
    [self.navigationController pushViewController:a animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (_adView) {
            return _adView;
        }
        self.adView = [[CHGAdView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _adView.data = [self simulationData];
        _adView.isCycleShow = YES;//是否循环显示
        _adView.isTimerShow = YES;//是否启用定时切换
        _adView.isShowPageControll = YES;//是否显示pageControll
        _adView.dataSource = self;
        [_adView.chgMenu.gridView registerNibName:@"AdCell" forCellReuseIdentifier:@"AdCell"];
        return _adView;
    }
    return nil;
}



///模拟数据
-(NSArray*)simulationData{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSMutableDictionary * item;
    for (int i=0; i<3; i++) {
        item = [[NSMutableDictionary alloc] init];
        [item setObject:@[@"nav1",@"nav2",@"nav3"][i] forKey:@"icon"];
        [item setObject:[NSString stringWithFormat:@"标题：%i",i] forKey:@"title"];
        [array addObject:item];
    }
    return array;
}

@end
