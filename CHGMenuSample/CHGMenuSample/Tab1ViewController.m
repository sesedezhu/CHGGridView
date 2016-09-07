//
//  Tab1ViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "Tab1ViewController.h"
#import "Tab1BtnCell.h"
#import "TableViewCell.h"
#import "NavCell.h"
#import "SecondViewController.h"

#define imgData @[@"nav1",@"nav2",@"nav3",@"nav1"]

@interface Tab1ViewController ()

@end

@implementation Tab1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabPage = [[CHGTabPage alloc] initWithFrame:CGRectMake(0, _userVCMode ? 20 : 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (_userVCMode ? 20 : 64))];
    _tabPage.tabPageDataSource = self;
    _tabPage.gridViewDelegate = self;
    _tabPage.items = [self simulationData];
    _tabPage.selectedColor = [UIColor greenColor];
    _tabPage.normalColor = [UIColor grayColor];
    _tabPage.tabViewLoca = locationTop;//在顶部显示按钮区域
    _tabPage.itemBtnCellLocation = CHGTabViewItemBtnCellLocationBottom;
    _tabPage.slideIndicatorColor = [UIColor redColor];
    _tabPage.useVCMode = _userVCMode;//是否定义左侧和右侧的view
    [_tabPage.gridView registerNibName:@"TableViewCell" forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:_tabPage];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:_userVCMode animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

///模拟数据
-(NSArray*)simulationData{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSMutableDictionary * item;
    for (int i=0; i<imgData.count; i++) {
        item = [[NSMutableDictionary alloc] init];
        [item setObject:imgData[i] forKey:@"icon"];
        [item setObject:[NSString stringWithFormat:@"按钮%i",i] forKey:@"title"];
        [array addObject:item];
    }
    return array;
}

///返回页面
-(CHGGridViewCell*)tabPage:(id)tabPage itemAtIndex:(NSInteger)page suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(NSDictionary*)data{
    TableViewCell * cell = (TableViewCell*)[((CHGTabPage*)tabPage).gridView dequeueReusableCellWithIdentifier:@"TableViewCell" withPosition:page];
    cell.target = self;
    cell.orderType = page;
    return cell;
}

//获取自定义的btn
-(ItemBtnCell*)tabView:(id)tabView itemAtIndex:(NSInteger)position  suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(id)data{
    Tab1BtnCell * menuItemCell = [Tab1BtnCell initWithNibName:@"Tab1BtnCell"];
    menuItemCell.title.text = [data objectForKey:@"title"];
    return menuItemCell;
}

///item被点击
-(void)tabView:(id)tabView itemView:(id)itemView didSelectAtPosition:(NSInteger)position{
    NSLog(@"%li",position);
}

/// 返回滑动区域的高度
-(CGFloat)heightForSliderInTabPage:(id)tabPage{
    return 40;
}

//返回指示器的高度
-(CGFloat)tabView:(id)tabView heightForIndicatorInPosition:(NSInteger)position suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width{
    return 1.5;
}

///左边view
-(UIView*)viewForLeftViewInTabPage:(id)tabPage{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

///右边的view
-(UIView*)viewForRightViewInTabPage:(id)tabPage{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"菜单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
///页面选中时回调
-(void)tabView:(id)tabView onChangedPage:(NSInteger)page{
    
}

-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    
}

-(void)onLeftBtnClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onRightBtnClick:(id)sender {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"右边按钮被点击" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

@end
