//
//  ScreenshotsViewController.m
//  Objective-C
//
//  Created by QianTuFD on 2017/2/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import "ScreenshotsViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ScreenshotsViewController ()

@end

@implementation ScreenshotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    btn.frame =CGRectMake(130, 130, 30, 30);
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick:(UIButton *)sender

{
    
    [self savePhoto];
    
}

// 保存图片到相册功能，ALAssetsLibraryiOS9.0 以后用photoliabary 替代，

-(void)savePhoto

{
    
    UIImage * image = [self captureImageFromView:self.view];
    
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}

//截图功能

-(UIImage *)captureImageFromView:(UIView *)view

{
    CGRect frame = view.frame;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
