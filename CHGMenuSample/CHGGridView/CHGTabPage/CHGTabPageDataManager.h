//
//  CHGTabPageDataManager.h
//  CHGMenuSample
//
//  Created by Hogan on 2016/12/28.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGTabPageDataManager : NSObject

+(_Nonnull instancetype) sharedInstance;
+(_Nonnull instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(_Nonnull instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(_Nonnull instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
