//
//  CHGGridViewU.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGGridView.h"

///滑动状态
typedef NS_ENUM(NSUInteger, CHGGridViewScrollStatus) {
    CHGGridViewScrollStatusDefault, //默认位置，没有滑动的状态
    CHGGridViewScrollStatusLeft,///向左边滑动
    CHGGridViewScrollStatusRight,///向右边滑动
};

@interface CHGGridViewU : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,assign) NSInteger curryShowPage;///当前显示的页面
@property(nonatomic,assign) NSInteger row;//numberOfRowInPage;//一页中最多存在的cell数量
@property(nonatomic,assign) NSInteger column;//numberOfColumInPage;//一页中最多存在的行数
@property(nonatomic,assign) CGFloat cellHeight;//cell的高度
@property(nonatomic,assign) CGFloat cellWidth;//cell的宽度
@property(nonatomic,assign) NSInteger curryClumns;//当前创建的列
@property(nonatomic,assign) NSInteger curryPage;//当前创建的page
@property(nonatomic,strong) NSMutableArray * cells;
@property(nonatomic,weak) id<CHGGridViewDatasource> gridViewDatasource;
@property(nonatomic,strong) NSArray * items; //存放的数据
@property(nonatomic,assign) NSInteger maxCellOfPage;//一页最多能显示的cell的数量
@property(nonatomic,assign) NSInteger maxPage;///一共有几页


@property(nonatomic,strong) NSMutableDictionary * deques;///存放所有cell对象的字典，字典通过identifier获取CHGGridViewCell数组

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier;
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position;

@end
