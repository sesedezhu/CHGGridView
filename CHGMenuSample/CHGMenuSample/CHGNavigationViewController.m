//
//  CHGNavigationViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGNavigationViewController.h"
#import "NavCell.h"

@interface CHGNavigationViewController ()

@end

@implementation CHGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adView = [[CHGAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _adView.data = @[@"nav1",@"nav2",@"nav3"];
    _adView.isCycleShow = NO;//是否循环显示
    _adView.isTimerShow = NO;//是否启用定时切换
    _adView.isShowPageControll = YES;//是否显示pageControll
    _adView.dataSource = self;
    [self.view addSubview:_adView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


///构造返回的view  需要继承CHGGridViewCell类
-(CHGGridViewCell*)adView:(id)adView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
    NavCell * cell = [NavCell initWithNibName:@"NavCell"];
    cell.image.image = [UIImage imageNamed:(NSString*)data];
    cell.btn.hidden = position != 2;
    cell.click = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

///CHGGridViewCell被点击时候回调
-(void)adView:(id)adView didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    NSLog(@"%li",position);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
