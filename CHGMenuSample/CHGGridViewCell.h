//
//  CHGGridViewCell.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHGGridViewCell : UIControl{
    
}

//@property(nonatomic,weak) CHGGridViewCell * cell;
@property(nonatomic,weak) UIViewController * target;

+(id)initWithNibName:(NSString*) nibName;
///页面将显示
-(void)gridViewCellWillAppear;

///创建的时候
-(void)gridViewCellDidLoad;

///页面消失
-(void)gridViewCellDidDisappear;

@end
