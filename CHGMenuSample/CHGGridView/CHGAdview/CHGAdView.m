//
//  CHGAdView.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/7/5.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGAdView.h"

@implementation CHGAdView {
    BOOL isFinishd;
}

@synthesize chgMenu = _chgMenu;
@synthesize data = _data;
@synthesize isCycleShow = _isCycleShow;
@synthesize isTimerShow = _isTimerShow;
@synthesize isShowPageControll = _isShowPageControll;
@synthesize pageControl = _pageControl;
@synthesize isDragging = _isDragging;
@synthesize islayout = _islayout;
@synthesize dataSource = _dataSource;

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (_isCycleShow) {
        NSMutableArray * dataTemp = [[NSMutableArray alloc] initWithArray:_data];
        [dataTemp insertObject:[_data objectAtIndex:_data.count - 1] atIndex:0];
        [dataTemp addObject:[_data objectAtIndex:0]];
        _chgMenu.items = dataTemp;
        _pageControl.numberOfPages = _data.count;
    } else {
        _chgMenu.items = _data;
        _pageControl.numberOfPages = _data.count;
    }
    _pageControl.hidden = !_isShowPageControll;
    if (_isTimerShow && _isCycleShow) {
        [self startTimerShow];
    }
    
    
    //    if (_isCycleShow) {
    //
    //
    //    }
    //    [_chgMenu.gridView scrollRectToVisible:CGRectMake(_chgMenu.gridView.frame.size.width, 0, _chgMenu.gridView.frame.size.width, _chgMenu.gridView.frame.size.height) animated:NO];
}

-(void)reloadData{
    [_chgMenu reloadData];
}

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    [_chgMenu registerNibName:nib forCellReuseIdentifier:identifier];
}
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier  withPosition:(NSInteger)position {
    return [_chgMenu dequeueReusableCellWithIdentifier:identifier withPosition:position];
}

//启动定时器
-(void)startTimerShow{
    if (_timer != nil) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                  target:self
                                                selector:@selector(adveritisementScroll)
                                                userInfo:nil
                                                 repeats:YES];
}



- (void)adveritisementScroll
{
    if (_isDragging) {
        return;
    }
    
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page == (_chgMenu.items.count - 2) ? 0 : page;
    _pageControl.currentPage = page;
    [_chgMenu.gridView scrollRectToVisible:CGRectMake(_chgMenu.gridView.frame.size.width*(page+1),0,_chgMenu.gridView.frame.size.width,_chgMenu.gridView.frame.size.height) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    
    return self;
}

-(void)createView{
    self.chgMenu = [[CHGMenu alloc] initWithFrame:self.frame];
    _chgMenu.gridViewDatasource = self;
    _chgMenu.gridViewDelegate = self;
    _chgMenu.gridView.gridViewScrollDelegate = self;
    _chgMenu.tag = 1;
    _chgMenu.showPageControl = NO;
    _chgMenu.pageControl.backgroundColor = [UIColor redColor];
    [self addSubview:_chgMenu];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:_pageControl];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_isCycleShow && !isFinishd) {
        isFinishd = YES;
        [_chgMenu.gridView scrollRectToVisible:CGRectMake(_chgMenu.gridView.frame.size.width, 0, _chgMenu.gridView.frame.size.width, _chgMenu.gridView.frame.size.height) animated:NO];
    }
}


-(void)setData:(NSArray *)data{
    refresh = YES;
    _data = data;
}

//返回gridView中的行数
-(NSInteger)numberOfRowInCHGGridView:(id) gridView{
    return 1;
}
//返回gridView中的列数
-(NSInteger)numberOfcolumnInRow:(id) gridView{
    return 1;
}

//返回item的view
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary*)data{
    return [_dataSource adView:self itemAtIndex:position withData:data];
}

//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView {
    return self.frame.size.height;
}

-(void)menu:(id)menu didSelectInPosition:(NSInteger)position withData:(NSDictionary*)data{
    [_dataSource adView:self didSelectInPosition:position withData:data];
}

-(void)gridViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}

-(void)gridViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isDragging = NO;
    //计算拖动的页数
    float page = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = lroundf(page);
}

-(void)gridViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_isCycleShow) {
        CGFloat pagewidth = self.frame.size.width;
        int currentPage = floor((_chgMenu.gridView.contentOffset.x - pagewidth/ ([_chgMenu.items count])) / pagewidth) + 1;
        if (currentPage == 0) {
            [_chgMenu.gridView scrollRectToVisible:CGRectMake(_chgMenu.gridView.frame.size.width * ([_chgMenu.items count] - 2),0,_chgMenu.gridView.frame.size.width,_chgMenu.gridView.frame.size.height) animated:NO]; // 序号0 最后1页
        } else if (currentPage==([_chgMenu.items count] - 1)) {
            [_chgMenu.gridView scrollRectToVisible:CGRectMake(_chgMenu.gridView.frame.size.width,0,_chgMenu.gridView.frame.size.width,_chgMenu.gridView.frame.size.height) animated:NO]; // 最后+1,循环第1页
        }
    }
}

-(void)gridViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = lroundf(_isCycleShow ? page - 1 : page);
}

@end
