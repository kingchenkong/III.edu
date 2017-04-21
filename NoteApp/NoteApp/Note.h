//
//  Note.h
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import CoreData;
//@import UIKit;    // 都可以

//@interface Note : NSObject <NSCoding>
@interface Note : NSManagedObject

@property(nonatomic) NSString *text;
//@property(nonatomic) UIImage *image;
@property (nonatomic) NSString * imageName;

//for sort
//  這種方法 效率低 更動一筆資料位置 可能會更新吧筆資料庫資料
//  老師說找只需要更新一筆資料的方法,   找！！
@property (nonatomic) NSNumber * sequence;

-(UIImage *) image;
-(UIImage *) thumbnailImage;
@end



