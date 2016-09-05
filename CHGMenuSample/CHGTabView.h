//
//  CHGTabView.h
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/12.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridViewCell.h"
#import "ItemBtnCell.h"


///定义顶部按钮的滑动块的位置
typedef NS_ENUM(NSInteger,CHGTabViewItemBtnCellLocation){
    CHGTabViewItemBtnCellLocationTop,            //滑块在文字顶部
    CHGTabViewItemBtnCellLocationBottom          //滑块在文字底部
};

@protocol CHGTabItemDataSource <NSObject>


//获取自定义btn
-(ItemBtnCell*)tabView:(id)tabView itemAtIndex:(NSInteger)position suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width;

//获取数量
-(NSInteger)numberOfinTabView;

//返回指示器的高度
-(CGFloat)tabView:(id)tabView heightForIndicatorInPosition:(NSInteger)position suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width;

@optional
///item被点击
-(void)tabView:(id)tabView itemView:(id)itemView didSelectAtPosition:(NSInteger)position;

@end

@interface CHGTabView : UIView

@property(nonatomic,weak) id<CHGTabItemDataSource> tabItemDataSource;
@property(nonatomic,strong) UIView * slideIndicator;
@property(nonatomic,strong) UIColor * slideIndicatorColor;//滑块颜色
@property(nonatomic,assign) NSInteger currSelected;                     //当前选中的view的位置
@property(nonatomic,strong) NSMutableArray * btns;                      //所有btn对象
@property(nonatomic,strong) UIColor * selectedColor;                    //选中的颜色
@property(nonatomic,strong) UIColor * normalColor;                      //正常状态的颜色
@property(nonatomic,assign) CHGTabViewItemBtnCellLocation itemBtnCellLocation;
@property(nonatomic,assign) NSInteger lastPage;                         //上次选中的页面

-(CHGGridViewCell*)getCurrSelectedAfter;                                //获取当前选中按钮后面的一个
-(CHGGridViewCell*)getCurrSelectedBefore;                               //获取当前选中按钮前面的一个
-(CHGGridViewCell*)getCurrSelected;

@end
