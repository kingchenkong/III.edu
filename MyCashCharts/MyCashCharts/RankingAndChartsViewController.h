//
//  RankingAndChartsViewController.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailData.h"
#import "CoreDataHelper.h"
#import "RankingAndChartsViewController.h"
#import "CategoryTableViewController.h"
#import "DetailCategoryTableViewController.h"
#import "DetailDataViewController.h"
#import "CustomCell.h"
#import "CustomBarChartCell.h"
#import "CustomLineChartCell.h"
#import "ExpressObject.h"
#import "HistoryLogTableViewController.h"

//  Methods Class
#import "UIColor+Expanded.h"

//  PNCharts
#import "PNChart.h"

@interface RankingAndChartsViewController : UIViewController <PNChartDelegate,UITableViewDelegate,UITableViewDataSource>

//  PNChart
@property (nonatomic) PNLineChart *lineChart;
@property (nonatomic) PNBarChart *barChart;


//  DetailData
@property (nonatomic) DetailData *currentDetailData;
//  ExpressObject
@property (nonatomic) ExpressObject *currentExpressObject;

@property(nonatomic) NSMutableArray *sectionItem;
@property(nonatomic) NSMutableArray *cellItem;

@end
