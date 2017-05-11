//
//  DetailCategoryTableViewController.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableViewController.h"
#import "DetailDataViewController.h"
#import "AppDelegate.h"
#import "ExpressObject.h"

@interface DetailCategoryTableViewController : UITableViewController

//  DetailData
@property (nonatomic) DetailData *currentDetailData;
//  ExpressObject
@property (nonatomic) ExpressObject *currentExpressObject;


@property(nonatomic) BOOL isCategoryExpand;
@property(nonatomic) NSInteger currentCategory;
@property(nonatomic) NSString *currentCategoryColor;
@property(nonatomic) NSString *currentCategoryName;//  Max 11 item
//  飲食,交通,娛樂, 購物,個人,醫療, 家居,家庭,生活, 學習,其他

@property(nonatomic) NSMutableArray *cellDetailCategoryItem;

@end
