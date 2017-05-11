//
//  CategoryTableViewController.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCategoryTableViewController.h"
#import "AppDelegate.h"
#import "DetailData.h"
#import "ExpressObject.h"
//  Methods Class
#import "UIColor+Expanded.h"

@interface CategoryTableViewController : UITableViewController

//  DetailData
@property (nonatomic) DetailData *currentDetailData;
//  ExpressObject
@property (nonatomic) ExpressObject *currentExpressObject;


//  showList is Expand or Income
@property(nonatomic) BOOL isCategoryExpand;
//  Item: section, cell
@property(nonatomic) NSMutableArray *sectionItem;
@property(nonatomic) NSMutableArray *cellCategoryItem;//  共11項
//  飲食,交通,娛樂, 購物,個人,醫療, 家居,家庭,生活, 學習,其他

@end
