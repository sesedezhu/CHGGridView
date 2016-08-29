//
//  CHGGridViewCell.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGGridViewCell.h"

@implementation CHGGridViewCell

+(id)initWithNibName:(NSString*) nibName {
    NSArray * views = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    id view = [views objectAtIndex:0];
    CHGGridViewCell * cell = (CHGGridViewCell*)view;
    [cell gridViewCellDidLoad];
    return view;
}

/////将要添加到父试图中
//-(void)willMoveToSuperview:(UIView *)newSuperview{
//    [super willMoveToSuperview:newSuperview];
////    [self gridViewCellWillAppear];
//    [self gridViewCellDidLoad];
//}

//-(void)willMoveToWindow:(UIWindow *)newWindow{
//    [super willMoveToWindow:newWindow];
//    [self gridViewCellDidLoad];
//    
////    NSLog(@"willMoveToWindow   inGRidViewCell");
//    
//}
//
//
//-(void)didAddSubview:(UIView *)subview{
//    [super didAddSubview:subview];
//    NSLog(@"didAddSubview");
//}
//
////完成添加view到父试图中
//-(void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    
//}
//
//-(void)removeFromSuperview{
//    [super removeFromSuperview];
//    [self gridViewCellDidDisappear];
//}
//
/////页面加载完毕
//-(void)gridViewCellDidLoad{
//    
//}
//

-(void)gridViewCellDidLoad{
    
}

///页面将显示
-(void)gridViewCellWillAppear{
    
}

///页面消失
-(void)gridViewCellDidDisappear{
    
}

//
/////页面将消失
//-(void)gridViewCellDidDisappear{
//    
//}

@end
