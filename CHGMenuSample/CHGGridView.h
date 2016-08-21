//
//  CHGGridView.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridViewCell.h"

///实现数据 功能
@protocol CHGGridViewDatasource <NSObject>
//返回gridView中的行数
-(NSInteger)numberOfRowInCHGGridView:(id) gridView;
//返回gridView中的列数
-(NSInteger)numberOfcolumnInRow:(id) gridView;
//返回item的view
//-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position;
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data;
//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView;

@end

///点击GridView回调
@protocol CHGGridViewDelegate <NSObject>

-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data;

@end

@interface CHGGridView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,strong) NSArray * items;
@property(nonatomic,strong) NSMutableArray * cells;
@property(nonatomic,weak) id<CHGGridViewDatasource> gridViewDatasource;
@property(nonatomic,weak) id<CHGGridViewDelegate> gridViewDelegate;
//@property(nonatomic,assign) BOOL layoutEnable;

//新增内存优化方案
@property(nonatomic,strong) NSMutableDictionary * queue;//存放实例化的cell数据

//-(void)registerWithNibName:(NSString*)nibName;
-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier;
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position;

@property(nonatomic,assign) NSInteger curryShowPage;///当前显示的页面
@property(nonatomic,assign) NSInteger row;//numberOfRowInPage;//一页中最多存在的cell数量
@property(nonatomic,assign) NSInteger column;//numberOfColumInPage;//一页中最多存在的行数
@property(nonatomic,assign) CGFloat cellHeight;//cell的高度
@property(nonatomic,assign) CGFloat cellWidth;//cell的宽度

-(void)reloadData;


@end
