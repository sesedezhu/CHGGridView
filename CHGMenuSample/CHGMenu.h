//
//  CHGMenu.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridView.h"

//typedef NS_ENUM(NSInteger,PageControlShow){
//    PageControlShowNone,//不显示
//    PageControlShowDown,//在试图下方显示
//    PageControlShowInner//重合显示
//};

@interface CHGMenu : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) CHGGridView * gridView;
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,weak) id<CHGGridViewDatasource> gridViewDatasource;
@property(nonatomic,weak) id<CHGGridViewDelegate> gridViewDelegate;
@property(nonatomic,strong) NSArray * items;
@property(nonatomic,assign) BOOL showPageControl;
//@property(nonatomic,assign) PageControlShow pageControlShow;

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier;
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier  withPosition:(NSInteger)position;

@end
