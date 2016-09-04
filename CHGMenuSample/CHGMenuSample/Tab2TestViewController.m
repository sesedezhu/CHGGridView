//
//  Tab2TestViewController.m
//  CHGMenuSample
//
//  Created by Hogan on 16/8/31.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "Tab2TestViewController.h"
#import "TableViewCell.h"
#import "Tab1BtnCell.h"
#import "Tab11Cell.h"

@interface Tab2TestViewController ()

@end

@implementation Tab2TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabPage = [[CHGTabPage alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    _tabPage.tabPageDataSource = self;
    _tabPage.gridViewDelegate = self;
    _tabPage.items = @[@"按钮1",@"按钮2",@"按钮3",@"按钮4"];
    _tabPage.tag = 1;
    _tabPage.selectedColor = [UIColor redColor];
    _tabPage.normalColor = [UIColor grayColor];
    _tabPage.tabViewLoca = locationBottom;//在顶部显示按钮区域
    _tabPage.itemBtnCellLocation = CHGTabViewItemBtnCellLocationBottom;
    _tabPage.slideIndicatorColor = [UIColor redColor];
    _tabPage.useVCMode = NO;//是否定义左侧和右侧的view
    [self.view addSubview:_tabPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///返回页面
-(CHGGridViewCell*)tabPage:(id)tabPage itemAtIndex:(NSInteger)page suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(NSDictionary*)data{
    Tab11Cell * cell = [Tab11Cell initWithNibName:@"Tab11Cell"];
//    cell.target = self;
    return cell;
}

//获取自定义的btn
-(ItemBtnCell*)tabView:(id)tabView itemAtIndex:(NSInteger)position  suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(id)data{
    Tab1BtnCell * menuItemCell = [Tab1BtnCell initWithNibName:@"Tab1BtnCell"];
    menuItemCell.title.text = data;
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
//    [btn addTarget:self action:@selector(onLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

///右边的view
-(UIView*)viewForRightViewInTabPage:(id)tabPage{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"菜单" forState:UIControlStateNormal];
    return btn;
}
///页面选中时回调
-(void)tabView:(id)tabView onChangedPage:(NSInteger)page{
    
}

-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    
}

@end
