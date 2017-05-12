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
#import "BaseNavigationController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTableViewController *mVC = [[MainTableViewController alloc] init];
    BaseNavigationController *mNav = [[BaseNavigationController alloc] initWithRootViewController:mVC];
    self.window.rootViewController = mNav;
    [self.window makeKeyAndVisible];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Zapfino" size:20],
                                                           NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    return YES;
}




- (NSString *)uuid {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(kCFAllocatorDefault, cfstring));
    CFRelease(uuid);
    CFRelease(cfstring);
    return result;
}


@end
