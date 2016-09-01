//
//  Tab11Cell.h
//  CHGMenuSample
//
//  Created by Hogan on 16/8/31.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewCell.h"
#import "CHGTabPage.h"

@interface Tab11Cell : CHGGridViewCell<CHGTabPageDataSource,CHGGridViewDelegate>

@property(nonatomic,strong) CHGTabPage * tabPage;

@end
