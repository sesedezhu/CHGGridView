//
//  Tab1ViewController.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGTabPage.h"

@interface Tab1ViewController : UIViewController<CHGTabPageDataSource,CHGGridViewDelegate>

@property(nonatomic,strong) CHGTabPage * tabPage;
@property(nonatomic,assign) BOOL userVCMode;

@end
