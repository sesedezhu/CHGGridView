//
//  CHGGridViewU.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridView.h"
#import "CHGGridViewCell.h"


@implementation CHGGridView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

///从新加载数据
-(void)reloadData{
    [self createCellsOfPage:_curryPage];
}

///计算最大page数目
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
        _curryPage = 0;
        self.row = [_gridViewDatasource numberOfRowInCHGGridView:self];
        self.column = [_gridViewDatasource numberOfcolumnInRow:self];
        self.cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
        self.cellWidth = self.frame.size.width / _column;
        _maxCellOfPage = _row * _column;
        _maxPage = [self getTotailPageWithTotalColumn:_column andRow:_row andTotalItem:_items.count];
        [self createAllRegisterCellType];
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

///创建一定数量的Cell（所有注册到CHGGridView中的cell类型）
-(void)createAllRegisterCellType{
    NSArray * identifiers = [_identifiersDic allKeys];
    for (int i=0; i<identifiers.count; i++) {
        [self createSomeCellWithNib:_identifiersDic[identifiers[i]] withCellReuseIdentifier:identifiers[i]];
    }
}

///通过nib 和 identifier创建2页数量的cell
-(void)createSomeCellWithNib:(NSString*)nib withCellReuseIdentifier:(NSString*)identifier{
    NSMutableArray * cells = [[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {///创建2页数据
        for (int j=0; j<_maxCellOfPage; j++) {
            [cells addObject:[CHGGridViewCell initWithNibName:nib]];
        }
    }
    [_queue setObject:cells forKey:identifier];
}

///注册Cell的nib文件
-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    if (_identifiersDic == nil) {
        _identifiersDic = [[NSMutableDictionary alloc] init];
    }
    [_identifiersDic setObject:nib forKey:identifier];
    if (_queue == nil) {
        self.queue = [[NSMutableDictionary alloc] init];
    }
}
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position{
    NSArray * cells = [_queue objectForKey:identifier];
    if (cells != nil) {
        if (_curryPage % 2 == 0) {//如果是偶数页面
            return cells[position%_maxCellOfPage + _maxCellOfPage];
        } else {//如果是奇数页面
            return cells[position%_maxCellOfPage];
        }
    }
    return nil;
}

///创建指定页面的cell
-(void)createCellsOfPage:(NSInteger)page{
    NSInteger columTemp = -1;
    for (long i= page * _maxCellOfPage; i<_maxCellOfPage * page+[self numberCellsOfPage:page]; i++) {
        if (i%_column == 0) {
            columTemp += 1;
        }
        [self createViewWithIndex:i withColum:columTemp inPage:page];
    }
}

///计算frame
-(CGRect)calculateFrameWithPosition:(NSInteger)i andColum:(NSInteger)colum andPage:(NSInteger)page{
    CGRect frame_ = CGRectMake((i % _column) * _cellWidth + page * self.frame.size.width,
                               (colum % _row == 0 ? 0 : colum % _row) * _cellHeight,
                               _cellWidth,
                               _cellHeight);
    return frame_;
}

///创建cell
-(void)createViewWithIndex:(NSInteger)i withColum:(NSInteger)colum inPage:(NSInteger)page{
    CHGGridViewCell * cell = [_gridViewDatasource gridView:self itemAtIndex:i withData:[_items objectAtIndex:i]];
    cell.frame = [self calculateFrameWithPosition:i andColum:colum andPage:page];
    cell.tag = i;
    cell.currInPage = page;//标记当前cell所在页面
    [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    if (_cells == nil) {
        self.cells = [[NSMutableArray alloc] init];
    }
    [_cells addObject:cell == nil ? [[NSNull alloc] init] : cell];
    [self addSubview:cell];
}


-(void)cellClick:(id)sender {
    NSLog(@"点击%li",((CHGGridViewCell*)sender).tag);
    NSInteger tag = ((CHGGridViewCell*)sender).tag;
    NSDictionary * item = [_items objectAtIndex:tag];
    if ([_gridViewDatasource respondsToSelector:@selector(menu:didSelectInPosition:withData:)]) {
        [_gridViewDelegate menu:self didSelectInPosition:tag withData:item];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"将要滑动");
    _isDragging = YES;
    _isCreate = NO;
    _scrollStartX = scrollView.contentOffset.x;
    [_gridViewScrollDelegate gridViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isDragging = NO;
//    NSLog(@"手指结束拖动");
    [_gridViewScrollDelegate gridViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isCreate = NO;
    _scrollStatus = CHGGridViewScrollStatusDefault;
    [_gridViewScrollDelegate gridViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_gridViewScrollDelegate gridViewDidScroll:scrollView];
    CGFloat currX = scrollView.contentOffset.x;
    if (currX > _lastScrollDownX) {
//        NSLog(@"向左滑动");
        _scrollStatus = CHGGridViewScrollStatusLeft;
        if(!_isCreate){
            _isCreate = YES;
            _curryPage += 1;
            [self createCellsOfPage:_curryPage];
        }
    } else if(currX < _lastScrollDownX){
//        NSLog(@"向右滑动");
        _scrollStatus = CHGGridViewScrollStatusRight;
        if(!_isCreate){
            _isCreate = YES;
            if (_curryPage - 1 < 0) {
                return;
            } else {
                _curryPage -= 1;
                [self createCellsOfPage:_curryPage];
            }
        }
    } else {
        NSLog(@"滑动结束");
        _scrollStatus = CHGGridViewScrollStatusDefault;
    }
    _lastScrollDownX = currX;
    CGFloat page = scrollView.contentOffset.x / self.frame.size.width;
    _curryPage = lroundf(page);
    
}

@end
