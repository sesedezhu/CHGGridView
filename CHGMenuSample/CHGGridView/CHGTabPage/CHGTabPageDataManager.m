//
//  CHGTabPageDataManager.m
//  CHGMenuSample
//
//  Created by Hogan on 2016/12/28.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGTabPageDataManager.h"

@implementation CHGTabPageDataManager {
    NSMutableDictionary * data;
}

+(_Nonnull instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id baseSingleTon = nil;
    dispatch_once(&pred, ^{
        baseSingleTon = [super new];
    });
    return baseSingleTon;
}

@end
