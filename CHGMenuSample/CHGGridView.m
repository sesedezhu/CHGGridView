//
//  CHGGridView.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGGridView.h"

@implementation CHGGridView

@synthesize items = _items;
@synthesize cells = _cells;
@synthesize gridViewDatasource = _gridViewDatasource;
@synthesize gridViewDelegate = _gridViewDelegate;
@synthesize layoutEnable = _layoutEnable;

//#ifdef _FOR_DEBUG_
//-(BOOL) respondsToSelector:(SEL)aSelector {
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
//    return [super respondsToSelector:aSelector];
//}
//#endif

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        _layoutEnable = YES;
    }
    return self;
}

-(void)reloadData{
    for (UIView * view in [self subviews]) {
        [view removeFromSuperview];
    }
    [self createView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_gridViewDatasource == nil) {
        return;
    }
    if (!_layoutEnable) {
        return;
    }
    _layoutEnable = NO;
    [self createView];
}


-(void)createView{
    NSInteger row = [_gridViewDatasource numberOfRowInCHGGridView:self];
    NSInteger column = [_gridViewDatasource numberOfcolumnInRow:self];
    CGFloat cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
    CGFloat cellWidth = self.frame.size.width / column;
    NSInteger curryPage = -1;
    NSInteger curryClumns = -1;
    for (int i=0; i<_items.count; i++) {
        if (i % column == 0) {
            curryClumns += 1;
        }
        if (i % (row * column) == 0) {
            curryPage += 1;
        }
        CGRect frame_ = CGRectMake((i % column) * cellWidth + curryPage * self.frame.size.width,
                                   (curryClumns % row == 0 ? 0 : curryClumns % row) * cellHeight,
                                   cellWidth,
                                   cellHeight);
        
        CHGGridViewCell * cell = [_gridViewDatasource gridView:self itemAtIndex:i withData:[_items objectAtIndex:i]];
        cell.frame = frame_;
        cell.tag = i;
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        if (_cells == nil) {
            self.cells = [[NSMutableArray alloc] init];
        }
        [_cells addObject:cell == nil ? [[NSNull alloc] init] : cell];
        [self addSubview:cell];
    }
    self.contentSize = CGSizeMake(self.frame.size.width * (curryPage + 1), 20);
}


-(void)cellClick:(id)sender {
//    NSLog(@"%li 被点击",((CHGGridViewCell*)sender).tag);
    NSInteger tag = ((CHGGridViewCell*)sender).tag;
    NSDictionary * item = [_items objectAtIndex:tag];
    [_gridViewDelegate menu:self didSelectInPosition:tag withData:item];
}

@end
