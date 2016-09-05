//
//  NewGridViewTestViewController.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridView.h"

@interface NewGridViewTestViewController : UIViewController<CHGGridViewDatasource>

@property(nonatomic,strong) NSString * a;
@property(nonatomic,strong) CHGGridView * gridViewU;

@end
