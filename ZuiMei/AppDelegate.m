//
//  AppDelegate.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "AppDelegate.h"
#import "DSDrawerController.h"
#import "DSDaylyController.h"
#import "DSMenuController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 创建两个视图控制器,并初始化抽屉视图控制器
    DSDaylyController *daylyVC = [[DSDaylyController alloc] init];
    DSMenuController *menuVC = [[DSMenuController alloc] initWithNibName:@"DSMenuController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:daylyVC];
    nav.navigationBarHidden = YES;
    nav.view.backgroundColor = daylyVC.view.backgroundColor;
    DSDrawerController *drawerVC = [[DSDrawerController alloc] initWithMainViewController:nav menuViewController:menuVC menuViewWidth:(CGFloat)self.window.bounds.size.width * 0.9];
    menuVC.delegate = drawerVC;
    daylyVC.drawerVC = drawerVC;
    self.window.rootViewController = drawerVC;
    
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

@end
