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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.queue = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (_cells == nil || _cells.count == 0) {
        self.row = [_gridViewDatasource numberOfRowInCHGGridView:self];
        self.column = [_gridViewDatasource numberOfcolumnInRow:self];
        self.cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
        self.cellWidth = self.frame.size.width / _column;
        [self createView];
    }
    
}

///注册cell
-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    CHGGridViewCell * cell = [CHGGridViewCell initWithNibName:nib];
    NSMutableArray * identifierArray = [_queue objectForKey:identifier];
    if (identifierArray == nil) {
        identifierArray = [[NSMutableArray alloc] init];
    }
    [identifierArray addObject:cell];
    [_queue setObject:identifierArray forKey:identifier];
}

///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position{
    NSMutableArray * identifierArray = [_queue objectForKey:identifier];
    CHGGridViewCell * cell;
    NSInteger numberOfPageCount = _row * _column;///一页有几个cell
    NSInteger m = position % numberOfPageCount;
    if (m >= identifierArray.count) {///这种情况应该实例化一个cell
        cell = [CHGGridViewCell initWithNibName:identifier];
        [identifierArray addObject:cell];
        [_queue setObject:identifierArray forKey:identifier];
    } else {
        cell = [identifierArray objectAtIndex:m];
    }
    return cell;
}

-(void)reloadData{
    for (UIView * view in [self subviews]) {
        [view removeFromSuperview];
    }
    _cells = nil;
    [self createView];
}

-(void)createView{
    NSInteger curryPage = -1;
    NSInteger curryClumns = -1;
    for (int i=0; i<_items.count; i++) {
        if (i % _column == 0) {
            curryClumns += 1;
        }
        if (i % (_row * _column) == 0) {
            curryPage += 1;
        }
        CGRect frame_ = CGRectMake((i % _column) * _cellWidth + curryPage * self.frame.size.width,
                                   (curryClumns % _row == 0 ? 0 : curryClumns % _row) * _cellHeight,
                                   _cellWidth,
                                   _cellHeight);
        
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
    self.contentSize = CGSizeMake(self.frame.size.width * (curryPage + 1), 1);
    if ([_gridViewDatasource respondsToSelector:@selector(onCreateFinished)]) {
        [_gridViewDatasource onCreateFinished];
    }
}


-(void)cellClick:(id)sender {
    NSInteger tag = ((CHGGridViewCell*)sender).tag;
    NSDictionary * item = [_items objectAtIndex:tag];
    if ([_gridViewDatasource respondsToSelector:@selector(menu:didSelectInPosition:withData:)]) {
        [_gridViewDelegate menu:self didSelectInPosition:tag withData:item];
    }
}

@end
