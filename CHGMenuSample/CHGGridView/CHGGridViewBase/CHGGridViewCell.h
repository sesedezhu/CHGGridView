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
@property(nonatomic,assign) NSInteger currInPage;//当前cell所在页面  如果等于－1 则不在view中

+(id)initWithNibName:(NSString*) nibName;
///页面将显示
-(void)gridViewCellWillAppear;
///页面已经显示
-(void)gridViewCellDidAppear;
///创建的时候
-(void)gridViewCellDidLoad;
///页面即将消失
-(void)gridViewCellWillDisappear;
///页面已经消失
-(void)gridViewCellDidDisappear;

@end
