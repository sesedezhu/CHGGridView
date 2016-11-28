//
//  CHGNavigationViewController.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGNavigationViewController.h"
#import "NavCell.h"
#import "UIImageView+AFNetworking.h"

@interface CHGNavigationViewController ()

@end

@implementation CHGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adView = [[CHGAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _adView.data = @[@"http://ww1.sinaimg.cn/large/7efb7362jw1e3rgypjtzvj.jpg",
                     @"http://img.3366.com/fileupload/img/commmanage/151/6780_1.jpg",
                     @"http://pic1.nipic.com/2008-11-05/2008115214135913_2.jpg"];
    _adView.isCycleShow = NO;//是否循环显示
    _adView.isTimerShow = NO;//是否启用定时切换
    _adView.isShowPageControll = YES;//是否显示pageControll
    _adView.dataSource = self;
    [_adView.chgMenu.gridView registerNibName:@"NavCell" forCellReuseIdentifier:@"NavCell"];
    [self.view addSubview:_adView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


///构造返回的view  需要继承CHGGridViewCell类
-(CHGGridViewCell*)adView:(id)adView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
//    NavCell * cell = [NavCell initWithNibName:@"NavCell"];
    NavCell * cell = (NavCell*)[((CHGAdView*)adView).chgMenu.gridView dequeueReusableCellWithIdentifier:@"NavCell" withPosition:position];
//    cell.image.image = [UIImage imageNamed:(NSString*)data];
    [cell.image setImageWithURL:[NSURL URLWithString:(NSString*)data]];
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
