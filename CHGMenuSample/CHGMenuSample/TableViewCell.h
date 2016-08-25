//
//  TableViewCell.h
//  CHGMenuSample
//
//  Created by 陈 海刚 on 16/8/21.
//  Copyright © 2016年 陈 海刚. All rights reserved.
//

#import "CHGGridViewCell.h"

typedef void(^TableViewClick)(id tableView,NSIndexPath * indexPath);

@interface TableViewCell : CHGGridViewCell<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutlet UITableView * tableView;
@property(nonatomic,assign) NSInteger orderType;//订单类型
@property(nonatomic,strong) TableViewClick tableViewClick;

@end
