//
//  CHGGridViewU.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
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
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data;
//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView;

@optional
///创建完毕回调
-(void)onCreateFinished;

@end

///CHGGridView滑动delegate
@protocol CHGGridViewScrollDelegate <NSObject>

-(void)gridViewWillBeginDragging:(UIScrollView *)scrollView;

-(void)gridViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

-(void)gridViewDidEndDecelerating:(UIScrollView *)scrollView ;

-(void)gridViewDidScroll:(UIScrollView *)scrollView;

@end

///点击GridView回调
@protocol CHGGridViewDelegate <NSObject>

@optional
-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data;

@end



///滑动状态
typedef NS_ENUM(NSUInteger, CHGGridViewScrollStatus) {
    CHGGridViewScrollStatusDefault, //默认位置，没有滑动的状态
    CHGGridViewScrollStatusLeft,///向左边滑动
    CHGGridViewScrollStatusRight,///向右边滑动
};

@interface CHGGridView : UIScrollView<UIScrollViewDelegate>

//@property(nonatomic,assign) NSInteger curryShowPage;///当前显示的页面
@property(nonatomic,assign) NSInteger row;//numberOfRowInPage;//一页中最多存在的cell数量
@property(nonatomic,assign) NSInteger column;//numberOfColumInPage;//一页中最多存在的行数
@property(nonatomic,assign) CGFloat cellHeight;//cell的高度
@property(nonatomic,assign) CGFloat cellWidth;//cell的宽度
//@property(nonatomic,assign) NSInteger curryClumns;//当前创建的列
@property(nonatomic,assign) NSInteger curryPage;//当前创建的page
//@property(nonatomic,strong) NSMutableArray * cells;
@property(nonatomic,weak) id<CHGGridViewDatasource> gridViewDatasource;
@property(nonatomic,weak) id<CHGGridViewDelegate> gridViewDelegate;
@property(nonatomic,weak) id<CHGGridViewScrollDelegate> gridViewScrollDelegate;
@property(nonatomic,strong) NSArray * items; //存放的数据
@property(nonatomic,assign) NSInteger maxCellOfPage;//一页最多能显示的cell的数量
@property(nonatomic,assign) NSInteger maxPage;///一共有几页



@property(nonatomic,assign) CGFloat lastScrollDownX;//上一次按下的位置
@property(nonatomic,assign) CGFloat scrollStartX;///第一次(开始)滑动的位置
@property(nonatomic,assign) BOOL isDragging;// 手指拖动中
@property(nonatomic,assign) BOOL isCreate;// 是否已经创建
@property(nonatomic,assign) CHGGridViewScrollStatus scrollStatus;
@property(nonatomic,strong)NSMutableDictionary * identifiersDic; ///保存identifier  所有注册的cell 类


@property(nonatomic,strong) NSMutableDictionary * queue;///存放所有cell对象的字典，字典通过identifier获取CHGGridViewCell数组

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier;
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position;

-(void)reloadData;

@end
