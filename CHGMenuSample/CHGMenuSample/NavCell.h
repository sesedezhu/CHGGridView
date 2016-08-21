//
//  NavCell.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewCell.h"

typedef void(^Click)();

@interface NavCell : CHGGridViewCell

@property(nonatomic,strong) IBOutlet UIImageView * image;
@property(nonatomic,strong) IBOutlet UIButton * btn;
@property(nonatomic,strong) Click click;

-(IBAction)btnClick:(id)sender;

@end
