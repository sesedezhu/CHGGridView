//
//  CHGGridViewCell.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHGGridViewCell : UIControl

@property(nonatomic,weak) UIViewController * target;

///页面加载完毕
-(void)gridViewCellDidLoad;
//页面将显示
-(void)gridViewCellWillAppear;
///页面将消失
-(void)gridViewCellDidDisappear;

+(id)initWithNibName:(NSString*) nibName;

@end
