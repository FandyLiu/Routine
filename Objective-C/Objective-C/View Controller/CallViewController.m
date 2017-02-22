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
                         ];
    }
    return _titlesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self addCallButtons];
}


#pragma mark - Private Instance methods

static CGFloat const btnHeight = 40.f;
static CGFloat const margin = 10.f;

- (void)addCallButtons {
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.center = self.view.center;
    NSInteger count = 3;
    contentView.bounds = CGRectMake(0.f, 0.f, 150.f, count * (btnHeight + margin) - margin);
    
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

- (void)touch:(UIButton *)btn {
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
            /*
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES} completionHandler:^(BOOL success) {
             if (success) {
             [[DHAlertController alloc] alertViewWithTitle:@"提示" message:@"是否拨号" hideTime:2.0f];
             }else{
             [[DHAlertController alloc] alertViewWithTitle:@"提示" message:@"无法拨号" hideTime:2.0f];
             }
             }];
             */
        }
            break;
            
        default:
            break;
    }
    
}

@end
