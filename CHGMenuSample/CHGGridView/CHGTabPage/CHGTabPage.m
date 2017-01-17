//
//  CHGTabPage.m
//  com.chg.CHGMenu
//
//  Created by hogan on 16/6/12.
//  Copyright © 2016年 hogan. All rights reserved.
//

#import "CHGTabPage.h"


@implementation CHGTabPage

@synthesize gridView = _gridView;
@synthesize tabPageDataSource = _tabPageDataSource;
@synthesize gridViewDelegate = _gridViewDelegate;
@synthesize items = _items;
@synthesize tabView = _tabView;
@synthesize tabViewLoca = _tabViewLoca;
@synthesize selectedColor = _selectedColor;
@synthesize normalColor = _normalColor;

- (instancetype)init
{
    self = [super init];
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

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)setCacheCountPage:(NSInteger)cacheCountPage {
    _cacheCountPage = cacheCountPage;
    _gridView.cacheCountPage = cacheCountPage;
}

-(void)registerNibName:(NSString*)nib forCellReuseIdentifier:(NSString*)identifier {
    [_gridView registerNibName:nib forCellReuseIdentifier:identifier];
}
///通过标识符获取cell
-(CHGGridViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier  withPosition:(NSInteger)position {
    return [_gridView dequeueReusableCellWithIdentifier:identifier withPosition:position];
}

-(void)reloadData{
    CGFloat sliderHeight = [_tabPageDataSource heightForSliderInTabPage:self];
    if (_tabViewLoca == locationTop) {
        if (_useVCMode) {
            _leftView.frame = CGRectMake(0, 0, 60, sliderHeight);
            _rightView.frame = CGRectMake(self.frame.size.width - 60, 0, 60, sliderHeight);
            if ([_tabPageDataSource respondsToSelector:@selector(viewForLeftViewInTabPage:)]) {
                UIView * leftView = [_tabPageDataSource viewForLeftViewInTabPage:self];
                [_leftView addSubview:leftView];
            }
            if ([_tabPageDataSource respondsToSelector:@selector(viewForRightViewInTabPage:)]) {
                UIView * rightView = [_tabPageDataSource viewForRightViewInTabPage:self];
                [_rightView addSubview:rightView];
            }
        }
        _tabView.frame = CGRectMake(_useVCMode ? 60 : 0, 0, self.frame.size.width - (_useVCMode ? 120 : 0), sliderHeight);
        _gridView.frame = CGRectMake(0, sliderHeight, self.frame.size.width, self.frame.size.height - sliderHeight);
    } else {
        _tabView.frame = CGRectMake(0, self.frame.size.height - sliderHeight, self.frame.size.width, sliderHeight);
        _gridView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - sliderHeight);
    }
    
    [_gridView reloadData];
}

-(void)createView{
    self.tabView = [[CHGTabView alloc] init];
    _tabView.tabItemDataSource = self;
    [self addSubview:_tabView];
    
    self.gridView = [[CHGGridView alloc] init];
    _gridView.gridViewDatasource = self;
    _gridView.gridViewScrollDelegate = self;
    [self addSubview:_gridView];
    
    ///添加辅助view
    self.leftView = [[UIView alloc] init];
    [self addSubview:_leftView];
    self.rightView = [[UIView alloc] init];
    [self addSubview:_rightView];
}

///显示指定页面
-(void)showPageWithPageIndex:(NSInteger)page{
    if ([_tabPageDataSource respondsToSelector:@selector(tabView:onChangedPage:)]) {
        [_tabPageDataSource tabView:self onChangedPage:page];
    }
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    _tabView.normalColor = _normalColor;
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    _tabView.selectedColor = _selectedColor;
}

-(void)setSlideIndicatorColor:(UIColor *)slideIndicatorColor{
    _slideIndicatorColor = slideIndicatorColor;
    _tabView.slideIndicatorColor = _slideIndicatorColor;
}

-(void)setItemBtnCellLocation:(CHGTabViewItemBtnCellLocation)itemBtnCellLocation{
    _itemBtnCellLocation = itemBtnCellLocation;
    _tabView.itemBtnCellLocation = _itemBtnCellLocation;
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    CGFloat sliderHeight = [_tabPageDataSource heightForSliderInTabPage:self];
    if (_tabViewLoca == locationTop) {
        if (_useVCMode) {
            _leftView.frame = CGRectMake(0, 0, 60, sliderHeight);
            _rightView.frame = CGRectMake(self.frame.size.width - 60, 0, 60, sliderHeight);
            if ([_tabPageDataSource respondsToSelector:@selector(viewForLeftViewInTabPage:)]) {
                UIView * leftView = [_tabPageDataSource viewForLeftViewInTabPage:self];
                [_leftView addSubview:leftView];
            }
            if ([_tabPageDataSource respondsToSelector:@selector(viewForRightViewInTabPage:)]) {
                UIView * rightView = [_tabPageDataSource viewForRightViewInTabPage:self];
                [_rightView addSubview:rightView];
            }
        }
        _tabView.frame = CGRectMake(_useVCMode ? 60 : 0, 0, self.frame.size.width - (_useVCMode ? 120 : 0), sliderHeight);
        _gridView.frame = CGRectMake(0, sliderHeight, self.frame.size.width, self.frame.size.height - sliderHeight);
    } else {
        _tabView.frame = CGRectMake(0, self.frame.size.height - sliderHeight, self.frame.size.width, sliderHeight);
        _gridView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - sliderHeight);
    }
    //    NSLog(@"%@",_tabView);
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if ([_tabPageDataSource respondsToSelector:@selector(tabView:onChangedPage:)]) {
        [_tabPageDataSource tabView:self onChangedPage:_tabView.currSelected];
    }
}

-(void)setItems:(NSArray *)items{
    _items = items;
    _gridView.items = _items;
}

#pragma - mark CHGGridView datasource method
-(void)setTabPageDataSource:(id<CHGTabPageDataSource>)tabPageDataSource{
    _tabPageDataSource = tabPageDataSource;
}

-(void)setGridViewDelegate:(id<CHGGridViewDelegate>)gridViewDelegate{
    _gridViewDelegate = gridViewDelegate;
    _gridView.gridViewDelegate = _gridViewDelegate;
}

#pragma mark CHGGridViewDatasource
///返回gridView中的行数
-(NSInteger)numberOfRowInCHGGridView:(id) gridView {
    return 1;
}

//返回gridView中的列数
-(NSInteger)numberOfcolumnInRow:(id) gridView{
    return 1;
}

//返回item的view
-(CHGGridViewCell*)gridView:(id)gridView itemAtIndex:(NSInteger) position withData:(NSDictionary *)data{
    CHGGridViewCell * cell = [_tabPageDataSource tabPage:self itemAtIndex:position suggestedHeight:_gridView.frame.size.height suggestedWidth:_gridView.frame.size.width withData:data];
    cell.frame = CGRectMake(0, 0, _gridView.frame.size.width, _gridView.frame.size.height);
    return cell;
}

//返回cell的高度   宽度自动计算，计算方式：屏幕宽度/列数
-(CGFloat)gridViewHeightForCell:(id)gridView{
    return self.frame.size.height - 40;
}

///创建完毕回调
-(void)onCreateFinished{
    [self showPageWithPageIndex:0];
}

#pragma mark CHGTabItemDataSource method
///获取自定义btn
-(ItemBtnCell*)tabView:(id)tabView itemAtIndex:(NSInteger)position  suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width{
    return [_tabPageDataSource tabView:tabView itemAtIndex:position suggestedHeight:height suggestedWidth:width withData:[_items objectAtIndex:position]];
}

//获取数量
-(NSInteger)numberOfinTabView{
    return _items.count;
}

///item被点击
-(void)tabView:(id)tabView itemView:(id)itemView didSelectAtPosition:(NSInteger)position{
    if ([_tabPageDataSource respondsToSelector:@selector(tabView:itemView:didSelectAtPosition:)]) {
        [_tabPageDataSource tabView:tabView itemView:itemView didSelectAtPosition:position];
    }
    scrollWithClick = YES;
    CGRect rect = CGRectMake(self.frame.size.width * position, 0, self.frame.size.width , self.frame.size.width);
    [_gridView scrollRectToVisible:rect animated:YES];
    [self showPageWithPageIndex:_tabView.currSelected];
}

//返回指示器的高度
-(CGFloat)tabView:(id)tabView heightForIndicatorInPosition:(NSInteger)position suggestedHeight:(CGFloat)height suggestedWidth:(CGFloat)width{
    return [_tabPageDataSource tabView:tabView heightForIndicatorInPosition:position suggestedHeight:height suggestedWidth:width];
}

#pragma mark UIScrollViewDelegate method
///开始滑动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    lastX = 0;
}

-(void)gridViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollWithClick = NO;
}

-(void)gridViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollWithClick = NO;
    lastX = 0;
}

-(void)gridViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_tabPageDataSource respondsToSelector:@selector(tabView:onChangedPage:)]) {
        [_tabPageDataSource tabView:self onChangedPage:_tabView.currSelected];
    }
}

-(void)gridViewDidScroll:(UIScrollView *)scrollView{
    CGRect f = _tabView.slideIndicator.frame;
    CGFloat p = scrollView.contentOffset.x / scrollView.contentSize.width;
    _tabView.slideIndicator.frame = CGRectMake(p*_tabView.frame.size.width, f.origin.y, f.size.width, f.size.height);
    if (!scrollWithClick) {
        _tabView.currSelected = lroundf(scrollView.contentOffset.x / scrollView.frame.size.width);
    }
}

@end
