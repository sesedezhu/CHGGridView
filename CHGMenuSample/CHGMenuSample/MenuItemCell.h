//
//  MenuItemCell.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewCell.h"

@interface MenuItemCell : CHGGridViewCell

@property(nonatomic,strong) IBOutlet UILabel * title;
@property(nonatomic,strong) IBOutlet UIImageView * image;

@end
