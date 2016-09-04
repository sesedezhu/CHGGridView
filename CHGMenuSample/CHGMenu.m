//
//  CHGMenu.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/8.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGMenu.h"

@implementation CHGMenu

@synthesize gridView = _gridView;
@synthesize pageControl = _pageControl;
@synthesize gridViewDatasource = _gridViewDatasource;
@synthesize items = _items;
@synthesize showPageControl = _showPageControl;
@synthesize gridViewDelegate = _gridViewDelegate;

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

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier{
    [_gridView registerNibName:nib forCellReuseIdentifier:identifier];
}
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier  withPosition:(NSInteger)position{
    return [_gridView dequeueReusableCellWithIdentifier:identifier withPosition:position];
}

-(void)createView{
    self.pageControl = [[UIPageControl alloc] init];
    [self addSubview:_pageControl];
    
    self.gridView = [[CHGGridView alloc] init];
    _gridView.delegate = self;
    [self addSubview:_gridView];
    self.backgroundColor = [UIColor whiteColor];
}


-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    NSInteger column = [_gridViewDatasource numberOfcolumnInRow:self];
    NSInteger row = [_gridViewDatasource numberOfRowInCHGGridView:self];
    
    NSInteger page = 0;
    if (_items.count % (column * row) == 0) {
        page = _items.count / (column * row);
    } else {
        page = ceil(_items.count / (column * row)) + 1;
    }
    self.pageControl.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
    self.gridView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - (_showPageControl ? 30 : 0));
    _gridView.tag = self.tag;
    
    _pageControl.numberOfPages = page;
    _pageControl.currentPage = currPage;
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
}

-(void)setItems:(NSArray *)items{
    _items = items;
    _gridView.items = _items;
}

-(void)setGridViewDatasource:(id<CHGGridViewDatasource>)gridViewDatasource{
    _gridViewDatasource = gridViewDatasource;
    _gridView.gridViewDatasource = _gridViewDatasource;
}

-(void)setGridViewDelegate:(id<CHGGridViewDelegate>)gridViewDelegate{
    _gridViewDelegate = gridViewDelegate;
    _gridView.gridViewDelegate = _gridViewDelegate;
}

-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
    self.gridView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = lroundf(page);
    currPage = _pageControl.currentPage;
}


@end
