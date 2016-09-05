//
//  NewGridViewTestViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "NewGridViewTestViewController.h"
#import "MenuItemCell.h"

#define imgData @[@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2"]

@interface NewGridViewTestViewController ()

@end

@implementation NewGridViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _a = @"按钮";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.gridViewU = [[CHGGridView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180+64)];
    _gridViewU.items = [self simulationData];
    _gridViewU.gridViewDatasource = self;
//    gridViewU.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_gridViewU];
    [_gridViewU registerNibName:@"MenuItemCell" forCellReuseIdentifier:@"MenuItemCell"];
    
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 180+64+20, [UIScreen mainScreen].bounds.size.width, 40)];
    [btn setTitle:@"更换数据" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick:(id)sender {
    _a = @"测试";
    _gridViewU.items = [self simulationData];
    [_gridViewU reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回gridView中的行数
-(NSInteger)numberOfRowInCHGGridView:(id) gridView {
    return 2;
}

//返回gridView中的列数
-(NSInteger)numberOfcolumnInRow:(id) gridView{
    return 4;
}

//返回item的view
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
    MenuItemCell * menuItemCell = (MenuItemCell*)[((CHGGridView*)gridView) dequeueReusableCellWithIdentifier:@"MenuItemCell" withPosition:position];
    menuItemCell.image.image = [UIImage imageNamed:[data objectForKey:@"icon"]];
    menuItemCell.title.text = [data objectForKey:@"title"];
    return menuItemCell;
}

//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView{
    return 90;
}

///模拟数据
-(NSArray*)simulationData{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSMutableDictionary * item;
    for (int i=0; i<imgData.count; i++) {
        item = [[NSMutableDictionary alloc] init];
        [item setObject:@"icon_" forKey:@"icon"];
        [item setObject:[NSString stringWithFormat:@"%@%i",_a,i] forKey:@"title"];
        [array addObject:item];
    }
    return array;
}

@end
