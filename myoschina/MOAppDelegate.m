//
//  MOAppDelegate.m
//  myoschina
//
//  Created by user on 13-2-27.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import "MOAppDelegate.h"
#import "MOMineViewController.h"
#import "MOMoreViewController.h"
#import "MONewsViewController.h"
#import "MOQaViewController.h"
#import "MOTweetViewController.h"

@interface MOAppDelegate ()

@property (nonatomic, retain) UITabBarController *rootViewController;

@end

@implementation MOAppDelegate

- (void)dealloc
{
    [_window release];
    [_rootViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    // 我的
    UIViewController *_mineViewController = [[[MOMineViewController alloc] init] autorelease];
    UINavigationController *_mineNav = [[UINavigationController alloc] initWithRootViewController:_mineViewController];
    _mineNav.tabBarItem.title = @"我的";
    
    // 更多
    UIViewController *_moreViewController = [[[MOMoreViewController alloc] init] autorelease];
    UINavigationController *_moreNav = [[UINavigationController alloc] initWithRootViewController:_moreViewController];
    _moreNav.tabBarItem.title = @"更多";
    
    // 综合
    UIViewController *_newsViewController = [[[MONewsViewController alloc] init] autorelease];
    UINavigationController *_newsNav = [[UINavigationController alloc] initWithRootViewController:_newsViewController];
    _newsNav.tabBarItem.title = @"综合";
    
    // 问答
    UIViewController *_qaViewController = [[[MOQaViewController alloc] init] autorelease];
    UINavigationController *_qaNav = [[UINavigationController alloc] initWithRootViewController:_qaViewController];
    _qaNav.tabBarItem.title = @"问答";
    
    // 动弹
    UIViewController *_tweetViewController = [[[MOTweetViewController alloc] init] autorelease];
    UINavigationController *_tweetNav = [[UINavigationController alloc] initWithRootViewController:_tweetViewController];
    _tweetNav.tabBarItem.title = @"动弹";
    
    _rootViewController = [[UITabBarController alloc] init];
    _rootViewController.hidesBottomBarWhenPushed = YES;
    _rootViewController.viewControllers = [NSArray arrayWithObjects:
                                           _newsNav,
                                           _qaNav,
                                           _tweetNav,
                                           _mineNav,
                                           _moreNav, nil];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectionIndicatorImage:nil];
    
    [_mineNav release];
    [_moreNav release];
    [_newsNav release];
    [_qaNav release];
    [_tweetNav release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = _rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
