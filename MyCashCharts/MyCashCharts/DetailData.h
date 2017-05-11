//
//  DetailData.h
//  cashcash
//
//  Created by 陳維漢 on 2016/8/26.
//  Copyright © 2016年 陳維漢. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import CoreData;

//@interface DetailData : NSObject
@interface DetailData : NSManagedObject

//  DetailData Property
@property(nonatomic) NSString *categoryName;        //  類別名
@property(nonatomic) NSString *categoryColor;       //  顏色字串 Hex

@property(nonatomic) NSString *detailCategoryName;  //  細項名
@property(nonatomic) NSString *dataName;            //  自訂項目名稱
@property(nonatomic) NSString *location;            //  消費地點 or收入地點
@property(nonatomic) NSString *manageProject;       //  管理本筆資料的 專案
@property(nonatomic) NSString *strDate;             //  String of Date YYYY-MM-dd


//  DataFileName
@property(nonatomic) NSString *categoryImageFileName;        //  Category 檔案名稱, 不包括副檔名
@property(nonatomic) NSString *detailCategoryImageFileName;  //   Detail Category 檔案名稱, 不包括副檔名

@property(nonatomic) NSNumber *cost;                //  本次消費
@property(nonatomic) NSNumber *isExpandItem;          //  YES : 支出, NO : 收入
@property(nonatomic) NSNumber *categoryArrayIndex;      //  Category -> DetailCategory 的 indexPath.row


//  NSDate
@property(nonatomic) NSDate *updateTime;            //  紀錄 or編輯時間

@end
