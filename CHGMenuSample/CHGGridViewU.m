//
//  CHGGridViewU.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewU.h"
#import "CHGGridViewCell.h"


@implementation CHGGridViewU{
    CGFloat lastScrollDownX;//上一次按下的位置
    CGFloat scrollStartX;///第一次(开始)滑动的位置
    BOOL dragging;// 手指拖动中
    BOOL isCreate;// 是否已经创建
    CHGGridViewScrollStatus scrollStatus;
    NSMutableDictionary * identifiersDic; ///保存identifier  所有注册的cell 类
}


- (instancetype)init
{
    self = [super init];
    if (self) {
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
    NSArray * identifiers = [identifiersDic allKeys];
    for (int i=0; i<identifiers.count; i++) {
        [self createSomeCellWithNib:identifiersDic[identifiers[i]] withCellReuseIdentifier:identifiers[i]];
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
    [_deques setObject:cells forKey:identifier];
    
}

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    if (identifiersDic == nil) {
        identifiersDic = [[NSMutableDictionary alloc] init];
    }
    [identifiersDic setObject:nib forKey:identifier];
    if (_deques == nil) {
        self.deques = [[NSMutableDictionary alloc] init];
    }
}
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position{
    NSArray * cells = [_deques objectForKey:identifier];
    if (cells != nil) {
        if (position < _maxCellOfPage) {
            NSLog(@"数据_：%li",position%_maxCellOfPage + _maxCellOfPage);
            return cells[position%_maxCellOfPage + _maxCellOfPage];
        } else {
            NSLog(@"数据：%li",position%_maxCellOfPage);
            return cells[position%_maxCellOfPage];
        }
    }
    return nil;
}

///创建指定页面的cell
-(void)createCellsOfPage:(NSInteger)page{
    for (int i= page * _maxCellOfPage; i<_maxCellOfPage * (page + 1); i++) {
        if (i >= _items.count) {
            return;
        }
        [self createViewWithIndex:i inPage:page];
    }
}

-(void)createViewWithIndex:(NSInteger)i inPage:(NSInteger)page{
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
    cell.currInPage = page;//标记当前cell所在页面
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
    NSLog(@"将要滑动");
    dragging = YES;
    scrollStartX = scrollView.contentOffset.x;
    if (_curryPage + 1 >= _maxPage) {
        return;
    }
//    [self createCellsOfPage:_curryPage + 1];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dragging = NO;
    scrollStatus = CHGGridViewScrollStatusDefault;
    isCreate = NO;
    NSLog(@"手指结束拖动");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    lastScrollDownX = 0;
    NSLog(@"scrollViewDidEndDecelerating");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currX = scrollView.contentOffset.x;
    if (currX > lastScrollDownX) {
        NSLog(@"向左滑动");
        scrollStatus = CHGGridViewScrollStatusLeft;
        if(!isCreate){
            [self createCellsOfPage:_curryPage + 1];
            isCreate = YES;
        }
    } else if(currX < lastScrollDownX){
        NSLog(@"向右滑动");
        scrollStatus = CHGGridViewScrollStatusRight;
        if(!isCreate){
            [self createCellsOfPage:_curryPage - 1];
            isCreate = YES;
        }
    } else {
        NSLog(@"滑动结束");
        scrollStatus = CHGGridViewScrollStatusDefault;
    }
    lastScrollDownX = currX;
    
    
}

@end
