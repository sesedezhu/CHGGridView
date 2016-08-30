//
//  CHGTabPage.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/12.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridView.h"
#import "CHGTabView.h"

///定义tab在视图中得位置
typedef NS_ENUM(NSInteger,CHGTabViewLocation){
    locationTop,            //tab在顶部
    locationBottom          //tab在底部
};

@protocol CHGTabPageDataSource <NSObject>
///返回页面
-(CHGGridViewCell*)tabPage:(id)tabPage itemAtIndex:(NSInteger)page suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(NSDictionary*)data;

//获取自定义的btn
-(ItemBtnCell*)tabView:(id)tabView itemAtIndex:(NSInteger)position  suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width withData:(id)data;


/// 返回滑动区域的高度
-(CGFloat)heightForSliderInTabPage:(id)tabPage;

//返回指示器的高度
-(CGFloat)tabView:(id)tabView heightForIndicatorInPosition:(NSInteger)position suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width;

@optional
///左边view
-(UIView*)viewForLeftViewInTabPage:(id)tabPage;
///右边的view
-(UIView*)viewForRightViewInTabPage:(id)tabPage;
///页面选中时回调
-(void)tabView:(id)tabView onChangedPage:(NSInteger)page;
///item被点击
-(void)tabView:(id)tabView itemView:(id)itemView didSelectAtPosition:(NSInteger)position;

@end

@interface CHGTabPage : UIView<CHGGridViewDatasource,CHGTabItemDataSource,UIScrollViewDelegate>{
    CGFloat  lastX;
    BOOL scrollWithClick;  //标记页面滑动是否为点击触发
//    UIView * leftView;                          ///左边试图
//    UIView * rightView;                         ///右边试图
}

@property(nonatomic,strong) CHGGridView * gridView;
@property(nonatomic,weak) id<CHGTabPageDataSource> tabPageDataSource;
@property(nonatomic,weak) id<CHGGridViewDelegate> gridViewDelegate;
@property(nonatomic,strong) NSArray * items;
@property(nonatomic,strong) CHGTabView * tabView;
@property(nonatomic,assign) CHGTabViewLocation tabViewLoca;
@property(nonatomic,assign) CHGTabViewItemBtnCellLocation itemBtnCellLocation;
@property(nonatomic,strong) UIColor * slideIndicatorColor;//滑块颜色
@property(nonatomic,strong) UIColor * selectedColor;                    //选中的颜色
@property(nonatomic,strong) UIColor * normalColor;                      //正常状态的颜色
@property(nonatomic,assign) BOOL useVCMode;                             ///使用controller模式， 实际上不是controller
@property(nonatomic,strong) UIView * leftView;                          ///左边试图
@property(nonatomic,strong) UIView * rightView;                         ///右边试图

-(void)reloadData;

@end
