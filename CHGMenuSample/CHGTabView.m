//
//  CHGTabView.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/12.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGTabView.h"

@implementation CHGTabView

@synthesize tabItemDataSource = _tabItemDataSource;
@synthesize slideIndicator = _slideIndicator;
@synthesize currSelected = _currSelected;
@synthesize btns = _btns;
@synthesize selectedColor = _selectedColor;
@synthesize normalColor = _normalColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"CHGTabView   initWithFrame");
        _currSelected = 0;
        self.slideIndicator = [[UIView alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        self.btns = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"CHGTabView   init");
    }
    return self;
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (_btns.count != 0) {
        return;
    }
    _slideIndicator.backgroundColor = _slideIndicatorColor == nil ? _selectedColor : _slideIndicatorColor;
    NSInteger counts = [_tabItemDataSource numberOfinTabView];
    CGFloat itemWidth = self.frame.size.width / counts;
    CGFloat itemHeight = self.frame.size.height;
    CGFloat indicatorHeight = [_tabItemDataSource tabView:self heightForIndicatorInPosition:0 suggestedHeight:itemHeight suggestedWidth:itemWidth];//指示器高度
    for (int i=0; i<counts; i++) {
        ItemBtnCell * cell = [_tabItemDataSource tabView:self itemAtIndex:i suggestedHeight:itemWidth suggestedWidth:itemHeight];
        cell.frame = CGRectMake(itemWidth * i, 0, itemWidth, itemHeight);
        cell.tag = i;
        [cell addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:cell];
        [self addSubview:cell];
        ((ItemBtnCell*)cell).title.textColor = i == 0 ? _selectedColor : _normalColor;
    }
    //判断滑块的位置
    _slideIndicator.frame = _itemBtnCellLocation == CHGTabViewItemBtnCellLocationTop ?
                            CGRectMake(0, 0, itemWidth, indicatorHeight) :
                            CGRectMake(0, itemHeight - indicatorHeight, itemWidth, indicatorHeight);
    [self addSubview:_slideIndicator];
}

///item 被点击
-(void)itemClick:(id)sender {
    NSInteger tag_ = ((CHGGridViewCell*)sender).tag;
    self.currSelected = tag_;
    if ([_tabItemDataSource respondsToSelector:@selector(tabView:itemView:didSelectAtPosition:)]) {
        [_tabItemDataSource tabView:self itemView:sender didSelectAtPosition:tag_];
    }
}

-(void)setCurrSelected:(NSInteger)currSelected{
    _lastPage = _currSelected;
    _currSelected = currSelected;
    for (ItemBtnCell * cell in _btns) {
        cell.title.textColor = cell.tag == _currSelected ? _selectedColor : _normalColor;
    }
}

///获取当前选中按钮后面的一个
-(CHGGridViewCell*)getCurrSelectedAfter{
    if (_currSelected  + 1 == _btns.count) {
        return nil;
    }
    return [_btns objectAtIndex:_currSelected + 1];
}

///获取当前选中按钮前面的一个
-(CHGGridViewCell*)getCurrSelectedBefore{
    if (_currSelected == 0) {
        return nil;
    }
    return [_btns objectAtIndex:_currSelected - 1];
}

-(CHGGridViewCell*)getCurrSelected {
    return [_btns objectAtIndex:_currSelected];
}
@end
