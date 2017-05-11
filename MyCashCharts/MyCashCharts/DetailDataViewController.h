//
//  DetailDataViewController.h
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
#import "ExpressObject.h"
//  Methods Class
#import "UIColor+Expanded.h"

#pragma mark -Protocol
@protocol DetailDataViewControllerDelegate <NSObject>
@optional
-(void)didFinishUpdateDeatilData:(DetailData *)detailData;
@end


@interface DetailDataViewController : UIViewController

@property (nonatomic,weak) id<DetailDataViewControllerDelegate> delegate;
//  任何型別 符合<DetailDataViewControllerDelegate> 這個 protocol的VC 都可以用 delegate 這個 property

//  DetailData
@property (nonatomic) DetailData *currentDetailData;
//  ExpressObject
@property (nonatomic) ExpressObject *currentExpressObject;


// For NavigationBar

// For Image Display
@property(nonatomic) NSInteger currentCategoryIndex;
@property(nonatomic) NSInteger currentDetailCategoryIndex;
@property(nonatomic) BOOL isCategoryExpand;

//  DetailData Property
@property(nonatomic) NSString *categoryName;            //  類別名
@property(nonatomic) NSString *categoryColor;           //  顏色字串 Hex
@property(nonatomic) NSString *detailCategoryName;      //  細項名
@property(nonatomic) NSString *dataName;                //  自訂項目名稱
@property(nonatomic) NSString *location;                //  消費地點 or收入地點
@property(nonatomic) NSString *manageProject;           //  管理本筆資料的 專案

//  DataFileName
@property(nonatomic) NSString *categoryImageFileName;        //  Category 檔案名稱, 不包括副檔名
@property(nonatomic) NSString *detailCategoryImageFileName;  //   Detail Category 檔案名稱, 不包括副檔名

@property(nonatomic) NSNumber *cost;                    //  本次消費
@property(nonatomic) NSNumber *isExpandItem;            //  YES : 支出, NO : 收入
@property(nonatomic) NSDate *updateTime;                //  紀錄 or編輯時間

//  Data Come From
@property(nonatomic) NSString *dataWayString;          //  資料來自哪個VC



@end
