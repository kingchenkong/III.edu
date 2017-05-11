//
//  AppDelegate.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic) NSString *homePath;        //Home Path
@property(nonatomic) NSString *documentPath;    //Document Path
@property(nonatomic) NSString *libraryPath;     //Library Path
@property(nonatomic) NSString *tmpPath;         //Tmp Path
@property(nonatomic) NSString *cachePath;       //Cache Path
@property(nonatomic) NSString *plistFilePath;   //Plist file Path

//  Methods
-(void) checkNSUserdefault;
-(void) getPathWithAppDelegateProperty;
-(void) movePlistToDocumentsFolder:(BOOL)nowMove plistFileName:(NSString *)plistFileName;


@end

