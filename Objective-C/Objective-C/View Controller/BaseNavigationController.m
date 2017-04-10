//
//  BaseNavigationController.m
//  Objective-C
//
//  Created by QianTuFD on 2017/3/14.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
