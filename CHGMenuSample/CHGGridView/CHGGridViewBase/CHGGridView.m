//
//  CHGGridViewU.m
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/9/4.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridView.h"
#import "CHGGridViewCell.h"


@implementation CHGGridView{
    NSInteger scrollEndBeforePage;///滑动结束之前所在的页面
    BOOL isPerformDisappearGridViewCells;//在一次拖动中是否执行了GridViewCell的willDisappear的方法
    BOOL isRegisterNib;//是否注册了Nib文件
    BOOL isInitedQueue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

///从新加载数据
-(void)reloadData{
//    isInitedQueue = YES;
    self.row = [_gridViewDatasource numberOfRowInCHGGridView:self];
    self.column = [_gridViewDatasource numberOfcolumnInRow:self];
    self.cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
    self.cellWidth = self.frame.size.width / _column;
    _maxCellOfPage = _row * _column;
    _maxPage = [self getTotailPageWithTotalColumn:_column andRow:_row andTotalItem:_items.count];
//    [self createAllRegisterCellType];
//    [self createCellsOfPage:0 fromInit:YES];
//    NSLog(@"计算宽度：%f",self.frame.size.width * _maxPage);
    self.contentSize = CGSizeMake(self.frame.size.width * _maxPage, 1);
    
    for (UIView * v in self.subviews) {
        [v removeFromSuperview];
    }
    [self createCellsOfPage:_curryPage fromInit:NO];
}

///计算最大page数目
-(NSInteger)getTotailPageWithTotalColumn:(NSInteger)column andRow:(NSInteger)row andTotalItem:(NSInteger)cellCount{
    NSInteger page = 0;
    if ((column * row) == 0) {
        return 0;
    }
    if (cellCount % (column * row) == 0) {
        page = cellCount / (column * row);
    } else {
        page = ceil(cellCount / (column * row)) + 1;
    }
    return page;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        _curryPage = 0;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        _curryPage = 0;
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        int f = self.contentOffset.x;
        int w = self.frame.size.width;
        if (f == 0 || w == 0) {
            return;
        }
        if (f % w == 0) {
            [self scrollViewDidEndDecelerating:self];
            [self removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
}


-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (_queue.count == 0 && !isInitedQueue) {
        isInitedQueue = YES;
        self.row = [_gridViewDatasource numberOfRowInCHGGridView:self];
        self.column = [_gridViewDatasource numberOfcolumnInRow:self];
        self.cellHeight = [_gridViewDatasource gridViewHeightForCell:self];
        self.cellWidth = self.frame.size.width / _column;
        _maxCellOfPage = _row * _column;
        _maxPage = [self getTotailPageWithTotalColumn:_column andRow:_row andTotalItem:_items.count];
        [self createAllRegisterCellType];
        [self createCellsOfPage:0 fromInit:YES];
        NSLog(@"计算宽度：%f",self.frame.size.width * _maxPage);
        self.contentSize = CGSizeMake(self.frame.size.width * _maxPage, 1);
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

-(NSInteger)getCachPage{
    return 3;//_cacheCountPage == 0 ? 3 : _cacheCountPage;
}

///通过nib 和 identifier创建2页数量的cell
-(void)createSomeCellWithNib:(NSString*)nib withCellReuseIdentifier:(NSString*)identifier{
    NSMutableArray * cells = [[NSMutableArray alloc] init];
    for (int i=0; i< self.getCachPage; i++) {///创建_cacheCountPage页数据
        for (int j=0; j<_maxCellOfPage; j++) {
            [cells addObject:[CHGGridViewCell initWithNibName:nib]];
        }
    }
    [_queue setObject:cells forKey:identifier];
}

///更具position 获取 GridViewCell
-(CHGGridViewCell*)indexPathWithPage:(NSInteger)position{
    CHGGridViewCell * cell = [_gridViewDatasource gridView:self itemAtIndex:position withData:[_items objectAtIndex:position]];
    return cell;
}

///执行即将消失的Cell
-(void)performWillDisappearGridViewCells{
    NSInteger count = [self numberCellsOfPage:scrollEndBeforePage];///获取当前页面cell的数量
    for (int i=0; i<count; i++) {
        //        NSLog(@"即将消失的cell数字：%li",scrollEndBeforePage * _maxCellOfPage+i);
        [[self indexPathWithPage:scrollEndBeforePage * _maxCellOfPage+i] gridViewCellWillDisappear];
    }
}

///执行cell的已经消失方法
-(void)performDidDisappearGridViewCells{
    NSInteger count = [self numberCellsOfPage:scrollEndBeforePage];///获取当前页面cell的数量
    for (int i=0; i<count; i++) {
        //        NSLog(@"已经消失的cell数字：%li",scrollEndBeforePage * _maxCellOfPage+i);
        [[self indexPathWithPage:scrollEndBeforePage * _maxCellOfPage+i] gridViewCellDidDisappear];
    }
}

///已经显示的cell
-(void)performDidAppearGridViewCells{
    NSInteger count = [self numberCellsOfPage:_curryPage];///获取当前页面cell的数量
    for (int i=0; i<count; i++) {
        //        NSLog(@"已经显示的cell数字：%li",_curryPage * _maxCellOfPage+i);
        [[self indexPathWithPage:_curryPage * _maxCellOfPage+i] gridViewCellDidAppear];
    }
}

///注册Cell的nib文件
-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    isRegisterNib = YES;
    if (_identifiersDic == nil) {
        _identifiersDic = [[NSMutableDictionary alloc] init];
    }
    [_identifiersDic setObject:nib forKey:identifier];
    if (_queue == nil) {
        self.queue = [[NSMutableDictionary alloc] init];
    }
}
///通过标识符以及当前position获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier withPosition:(NSInteger)position{
    NSArray * cells = [_queue objectForKey:identifier];
    if (cells != nil) {
        NSInteger p = _curryPage % self.getCachPage;
        return cells[position % _maxCellOfPage  + _maxCellOfPage * (2 - p)];
    }
    return nil;
}

///创建指定页面的cell
-(void)createCellsOfPage:(NSInteger)page fromInit:(BOOL)fromInitMethod{
    if (!fromInitMethod) {
        [self performWillDisappearGridViewCells];
    }
    
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
    return CGRectMake(
                      (i % _column) * _cellWidth + page * self.frame.size.width,
                      (colum % _row == 0 ? 0 : colum % _row) * _cellHeight,
                      _cellWidth,
                      _cellHeight
                      );
}

///创建cell
-(void)createViewWithIndex:(NSInteger)i withColum:(NSInteger)colum inPage:(NSInteger)page{
    CHGGridViewCell * cell = [_gridViewDatasource gridView:self itemAtIndex:i withData:[_items objectAtIndex:i]];
    cell.frame = [self calculateFrameWithPosition:i andColum:colum andPage:page];
    [cell gridViewCellWillAppear];
    cell.tag = i;
    cell.currInPage = page;//标记当前cell所在页面
    [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cell];
}

-(void)cellClick:(id)sender {
    NSInteger tag = ((CHGGridViewCell*)sender).tag;
    NSDictionary * item = [_items objectAtIndex:tag];
    if ([_gridViewDatasource respondsToSelector:@selector(menu:didSelectInPosition:withData:)]) {
        [_gridViewDelegate menu:self didSelectInPosition:tag withData:item];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    isPerformDisappearGridViewCells = NO;
    scrollEndBeforePage = _curryPage;
    _isDragging = YES;
    _isCreate = NO;
    _scrollStartX = scrollView.contentOffset.x;
    [_gridViewScrollDelegate gridViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isDragging = NO;
    [_gridViewScrollDelegate gridViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //        NSLog(@"滑动结束:%f",scrollView.contentOffset.x);
    [self performDidDisappearGridViewCells];
    [self performDidAppearGridViewCells];
    _isCreate = NO;
    scrollEndBeforePage = _curryPage;
    _scrollStatus = CHGGridViewScrollStatusDefault;
    [_gridViewScrollDelegate gridViewDidEndDecelerating:scrollView];
    isPerformDisappearGridViewCells = NO;
    [self createCellsOfPage:_curryPage fromInit:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_gridViewScrollDelegate gridViewDidScroll:scrollView];
    CGFloat currX = scrollView.contentOffset.x;
    //        NSLog(@"开始华东:%f",scrollView.contentOffset.x);
    if (currX > _lastScrollDownX) {
        //        NSLog(@"向左滑动");
        _scrollStatus = CHGGridViewScrollStatusLeft;
        if(!_isCreate){
            _isCreate = YES;
            _curryPage += 1;
            [self createCellsOfPage:_curryPage fromInit:NO];
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
                [self createCellsOfPage:_curryPage fromInit:NO];
            }
        }
    } else {
        _scrollStatus = CHGGridViewScrollStatusDefault;
    }
    _lastScrollDownX = currX;
    CGFloat page = scrollView.contentOffset.x / self.frame.size.width;
    _curryPage = lroundf(page);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    [self performDidDisappearGridViewCells];
    [self performDidAppearGridViewCells];
    _isCreate = NO;
    scrollEndBeforePage = _curryPage;
    _scrollStatus = CHGGridViewScrollStatusDefault;
    [_gridViewScrollDelegate gridViewDidEndScrollingAnimation:scrollView];
    isPerformDisappearGridViewCells = NO;
    [self createCellsOfPage:_curryPage fromInit:YES];
}

-(void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated{
    [super scrollRectToVisible:rect animated:animated];
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    isPerformDisappearGridViewCells = NO;
    scrollEndBeforePage = _curryPage;
    _isDragging = YES;
    _isCreate = NO;
    _scrollStartX = self.contentOffset.x;
}

@end
