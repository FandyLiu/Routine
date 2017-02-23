//
//  CallViewController.m
//  Objective-C
//
//  Created by QianTuFD on 2017/2/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import "CallViewController.h"
#import "FlatButton.h"

@interface CallViewController ()

@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation CallViewController

#pragma mark - lazy

- (NSArray *)titlesArray {
    if (_titlesArray == nil) {
        _titlesArray = @[@"URL tel:",
                         @"URL telprompt",
                         @"Web tel:",
                         @"自定义 alert",
                         ];
    }
    return _titlesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addCallButtons];
}


#pragma mark - Private Instance methods

static CGFloat const btnHeight = 40.f;
static CGFloat const margin = 10.f;

- (void)addCallButtons {
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.center = self.view.center;
    NSInteger count = self.titlesArray.count;
    contentView.bounds = CGRectMake(0.f, 0.f, 200.f, count * (btnHeight + margin) - margin);
    
    for (NSInteger i = 0; i < count; i++) {
        [self addOneButtonToView:contentView WithTag:i];
    }
    
}

- (void)addOneButtonToView:(UIView *)view WithTag:(NSInteger)tag {
    UIButton *button = [FlatButton button];
    button.tag = tag;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:self.titlesArray[tag] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0.f]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.f
                                                      constant:0.f]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:(btnHeight + margin) * tag]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0.f
                                                      constant:btnHeight]];
    
}

/*
 options目前可传入参数Key在UIApplication头文件只有一个:UIApplicationOpenURLOptionUniversalLinksOnly,其对应的Value为布尔值,默认为False.如该Key对应的Value为True,那么打开所传入的Universal Link时,只允许通过这个Link所代表的iOS应用跳转的方式打开这个链接,否则就会返回success为false,也就是说只有安装了Link所对应的App的情况下才能打开这个Universal Link,而不是通过启动Safari方式打开这个Link的代表的网站.
 
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]
 options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES}
 completionHandler:^(BOOL success) {
 
 }];
 
 NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
 
 */

- (void)touch:(UIButton *)btn {
//    UIApplicationOpenSettingsURLString；
    switch (btn.tag) {
        case 0:
        {
            // 直接到打电话界面
            NSString *str = @"tel:10010";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

        }
            break;
        case 1:
        {
            // 可以选择打不打电话
            NSString *str = @"telprompt://10010";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 2:
        {
            // 可以选择打不打电话
            NSString *str = @"tel:10010";
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
            break;
        case 3:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要拨打电话" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction * _Nonnull action) {
                NSString *str = @"tel:10010";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
            [alert addAction:action0];
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];

        }
            break;
            
        default:
            break;
    }
    
}

@end
