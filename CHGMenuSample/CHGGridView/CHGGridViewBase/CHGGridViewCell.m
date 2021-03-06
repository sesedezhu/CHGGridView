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
    cell.currInPage = -1;
    [cell gridViewCellDidLoad];
    return view;
}

-(void)gridViewCellDidLoad{
    
}

///页面将显示
-(void)gridViewCellWillAppear{
    
}

///页面已经显示完毕
-(void)gridViewCellDidAppear{
    
}

///页面即将消失
-(void)gridViewCellWillDisappear{
    
}

///页面已经消失
-(void)gridViewCellDidDisappear{
    
}

@end
