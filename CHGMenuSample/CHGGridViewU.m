//
//  CHGGridViewU.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewU.h"
#import "CHGGridViewCell.h"

@implementation CHGGridViewU


- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.pagingEnabled = YES;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


-(NSInteger)getTotailPageWithTotalColumn:(NSInteger)column andRow:(NSInteger)row andTotalItem:(NSInteger)cellCount{
    NSInteger page = 0;
    if (cellCount % (column * row) == 0) {
        page = cellCount / (column * row);
    } else {
        page = ceil(cellCount / (column * row)) + 1;
    }
    return page;
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (_cells == nil || _cells.count == 0) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        _curryPage = - 1;
        _curryClumns = -1;
        self.row = [_gridViewDatasource numberOfRowInCHGGridView:self];
        self.column = [_gridViewDatasource numberOfcolumnInRow:self];
        self.cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
        self.cellWidth = self.frame.size.width / _column;
        _maxCellOfPage = _row * _column;
        _maxPage = [self getTotailPageWithTotalColumn:_column andRow:_row andTotalItem:_items.count];
        
//        for (int i=0; i<_maxCellOfPage; i++) {
//            [self createViewWithIndex:i];
//        }
        [self createCellsOfPage:0];
        
        self.contentSize = CGSizeMake(self.frame.size.width * _maxPage, 1);
        self.backgroundColor = [UIColor orangeColor];
    }
    
}

///计算每一页的cell数量
-(NSInteger)numberCellsOfPage:(NSInteger)page{
    NSInteger expectCount = _maxCellOfPage * (page + 1);
    if (_items.count >= expectCount) {
        return _maxCellOfPage;
    } else {
        NSInteger count = expectCount - _items.count;
        if (count >= _maxCellOfPage) {
            return 0;
        } else {
            return _maxCellOfPage - count;
        }
    }
   
}

-(void)createCellsOfPage:(NSInteger)page{
    NSInteger * count = [self numberCellsOfPage:page];
    if (count == 0) {
        return;
    }
    for (int i= page * _maxCellOfPage; i<_maxCellOfPage * (page + 1); i++) {
        if (i >= _items.count) {
            return;
        }
        [self createViewWithIndex:i];
    }
}

-(void)createViewWithIndex:(NSInteger)i{
    if (i % _column == 0) {
        _curryClumns += 1;
    }
    if (i % (_row * _column) == 0) {
        _curryPage += 1;
    }
    CGRect frame_ = CGRectMake((i % _column) * _cellWidth + _curryPage * self.frame.size.width,
                               (_curryClumns % _row == 0 ? 0 : _curryClumns % _row) * _cellHeight,
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


-(void)cellClick:(id)sender {
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
    
    [self createCellsOfPage:_curryPage + 1];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

@end
