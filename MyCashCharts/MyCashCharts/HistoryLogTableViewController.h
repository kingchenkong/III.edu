//
//  HistoryLogTableViewController.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/8.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CustomHistoryLogCell.h"
#import "DetailData.h"
#import "UIColor+Expanded.h"

@interface HistoryLogTableViewController : UITableViewController
@property(nonatomic) NSMutableArray *historyLogArray;
@property(nonatomic) NSMutableArray *historyLogCurrentMonthArray;


@end
