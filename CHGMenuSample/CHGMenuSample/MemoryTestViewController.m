//
//  MemoryTestViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "MemoryTestViewController.h"
#import "MenuItemCell.h"

#define imgData @[@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3",@"nav1",@"nav2",@"nav3"]

@interface MemoryTestViewController ()

@end

@implementation MemoryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.menu = [[CHGMenu alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height-64)];
    _menu.items = [self simulationData];
    _menu.showPageControl = YES;//是否显示pageControll
    _menu.gridViewDatasource = self;
    _menu.gridViewDelegate = self;
    [self.view addSubview:_menu];
    [_menu registerNibName:@"MenuItemCell" forCellReuseIdentifier:@"MenuItemCell"];
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
    NSLog(@"gridView:%@",gridView);
    MenuItemCell * cell = (MenuItemCell*)[gridView dequeueReusableCellWithIdentifier:@"MenuItemCell" withPosition:position];
    cell.image.image = [UIImage imageNamed:[data objectForKey:@"icon"]];
    cell.title.text = [data objectForKey:@"title"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView{
    return 80;
}

-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary *)data{
    NSLog(@"%li",position);
}

@end
