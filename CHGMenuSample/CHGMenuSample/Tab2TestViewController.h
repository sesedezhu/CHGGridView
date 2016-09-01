//
//  Tab2TestViewController.h
//  CHGMenuSample
//
//  Created by Hogan on 16/8/31.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGTabPage.h"

@interface Tab2TestViewController : UIViewController<CHGTabPageDataSource,CHGGridViewDelegate>

@property(nonatomic,strong) UISegmentedControl * segmentedControl;
@property(nonatomic,strong) CHGTabPage * tabPage;
@property(nonatomic,strong) CHGTabPage * tabPage2;

@end
