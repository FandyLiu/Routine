//
//  AppDelegate.m
//  Objective-C
//
//  Created by QianTuFD on 2017/2/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import <FDCategories/FDCategories.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTableViewController *mVC = [[MainTableViewController alloc] init];
    UINavigationController *mNav = [[UINavigationController alloc] initWithRootViewController:mVC];
    self.window.rootViewController = mNav;
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Zapfino" size:20],
                                                           NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    return YES;
}


@end
