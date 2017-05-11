//
//  AppDelegate.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//


#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@import Firebase;



@interface AppDelegate ()
{
    BOOL enableNSUserDefaultMethods;
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    enableNSUserDefaultMethods = YES;
    //  是否啟動    NSUserDefaultMethods
    
    if (enableNSUserDefaultMethods) {
        
        [self movePlistToDocumentsFolder:YES plistFileName:@"CashPropertyList"];
        //  move Plist File To Documents Folder
        //  YES = Forced move
        //  NO = if exist then don't move
        
        //  Check Methods
        [self getPathWithAppDelegateProperty];
        [self checkNSUserdefault];
    }
    
    
    //  Fabric
    [Fabric with:@[[Crashlytics class]]];
    //  FireBase
    [FIRApp configure];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -NSUserDefault
-(void) movePlistToDocumentsFolder:(BOOL)nowMove plistFileName:(NSString *)plistFileName {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // Get Property list.plist path at project
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"];
    // Get destination path "copies"
    NSString *destinationPath = [NSString stringWithFormat:@"%@/Documents/%@.plist", NSHomeDirectory(), plistFileName];
    
    if (nowMove) {
        [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:nil];
        NSLog(@"noMove: YES, [Forced Move]");
    } else {
        
        // Check destination path, MyPropertyListDemo exist? if "doesn't",then copies
        if (![fileManager fileExistsAtPath:_plistFilePath]) {
            [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:nil];
            NSLog(@"noMove: NO, [Do Move] .plist is not found, move .plist file");
        } else {
            NSLog(@"noMove: NO, [Cancel Action] destinationPath is EXIST .plist file, ");
        }
    }
}

-(void) checkNSUserdefault {
    
    //  Get "CashPropertyList.plist" which at NSHomeDirectory()
    NSString *stringOfPlistPath = [NSString stringWithFormat:@"/Documents/CashPropertyList.plist"];
    NSString *plistPath = [NSString stringWithFormat:@"%@%@",NSHomeDirectory(),stringOfPlistPath];
    //  test plistPath
    NSLog(@"%@",plistPath);
    
    // Read all plist var at CashPropertyList.plist
    NSMutableDictionary *cashPropertyList = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    //  ##################################################################################
    //  check "CashPropertyList.plist" which at NSHomeDirectory()
    //  (1)  check [Dictionary] categoryData: categoryName, detailCategory
    NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
    
    //  (1-1)  check [Dictionary] categoryData: [Array] categoryName
    NSMutableArray *categoryName_Expand = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryName_Expand"]];
    for (NSString *name in categoryName_Expand) {
        NSLog(@"categoryName_Expand: %@", name);
    }
    NSLog(@"(1-1) is Done!");
    
    //  (1-2)  check [Dictionary] categoryData: [Array] categoryName
    NSMutableArray *categoryName_Income = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryName_Income"]];
    for (NSString *name in categoryName_Income) {
        NSLog(@"categoryName_Income: %@", name);
    }
    NSLog(@"(1-2) is Done!");
    
    //  (1-3)  check [Dictionary] categoryData: [Array] detailCategory
    NSMutableArray *detailCategory_Expand = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"detailCategory_Expand"]];
    for (int i = 0; i <[detailCategory_Expand count]; i+=1) {
        NSMutableArray *detailCategoryItem = [NSMutableArray arrayWithArray:[detailCategory_Expand objectAtIndex:i]];
        for (NSMutableArray *item in detailCategoryItem) {
            NSLog(@"categoryName: %@, detailCategory Item %d: %@", [categoryName_Expand objectAtIndex:i], i, item);
        }
    }
    NSLog(@"(1-3) is Done!");
    
    //  (1-4)  check [Dictionary] categoryData: [Array] detailCategory
    NSMutableArray *detailCategory_Income = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"detailCategory_Income"]];
    for (int i = 0; i <[detailCategory_Income count]; i+=1) {
        NSMutableArray *detailCategoryItem = [NSMutableArray arrayWithArray:[detailCategory_Income objectAtIndex:i]];
        for (NSMutableArray *item in detailCategoryItem) {
            NSLog(@"categoryName: %@, detailCategory Item %d: %@", [categoryName_Income objectAtIndex:i], i, item);
        }
    }
    NSLog(@"(1-4) is Done!");
    
    //  (2)  check [BOOL] nowIsExpand
    BOOL nowIsExpand = [cashPropertyList objectForKey:@"nowIsExpand"];
    NSLog(@"chooseExpandVC = %d", nowIsExpand);
    NSLog(@"(2) is Done!");
    
    //  (3)  check [Array] managerProject
    NSMutableArray *managerProject = [NSMutableArray arrayWithArray:[cashPropertyList objectForKey:@"managerProject"]];
    //    NSMutableArray *managerProject = [NSMutableArray arrayWithObject:cashPropertyList];
    for (NSString *name in managerProject) {
        NSInteger itemIndex = 0;
        NSLog(@"managerProject %ld: %@", itemIndex, name);
        itemIndex += 1;
    }
    NSLog(@"(3) is Done!");
    
    //  (4)  check [String] nowSelectedProject
    NSString *nowSelectedProjectName = [cashPropertyList objectForKey:@"nowSelectedProject"];
    NSLog(@"nowSelectedProject: %@", nowSelectedProjectName);
    NSLog(@"(4) is Done!");
    //  ##################################################################################
}

-(void) getPathWithAppDelegateProperty {
    
    //  ##################################################################################
    //  Get Path
    //Home Path
    _homePath= NSHomeDirectory();
    NSLog(@"%@", _homePath);
    
    //Document Path
    NSArray *docDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentPath = [docDirectory objectAtIndex:0];
    NSLog(@"%@", _documentPath);
    //  Plist Path
    _plistFilePath = [NSString stringWithFormat:@"%@/CashPropertyList.plist",_documentPath];
    NSLog(@"%@", _plistFilePath);
    
    //Library Path
    NSArray *libDirectory = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    _libraryPath = [libDirectory objectAtIndex:0];
    
    //Tmp Path
    _tmpPath = NSTemporaryDirectory();
    
    //Cache Path
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _cachePath = [cacPath objectAtIndex:0];
    //  ##################################################################################
}



@end
