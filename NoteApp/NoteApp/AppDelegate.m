//
//  AppDelegate.m
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
@import SystemConfiguration;    //  @ is import framework
@import Firebase;

// fabric
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()
@property (nonatomic) Reachability *reachability;

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // fabric
    [Fabric with:@[[Crashlytics class]]];
    
    [FIRApp configure]; //  讀GoogleService-info.plist
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    [self.reachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    [self reachabilityChanged:nil];
    
    NSLog(@"home = %@",NSHomeDirectory());
    NSLog(@"just for commit");
//    NSLog(@"just for commit");
//    NSLog(@"just for commit");

    
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)notification{
    if ( [self.reachability currentReachabilityStatus] == ReachableViaWiFi ) {
        
        NSLog(@"wifi");
        
    }else if ( [self.reachability currentReachabilityStatus] == ReachableViaWWAN ) {
        NSLog(@"3G");
        
    }else if ( [self.reachability currentReachabilityStatus] == NotReachable ) {
        NSLog(@"無網路");
    }

    
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

@end
