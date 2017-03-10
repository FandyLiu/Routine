//
//  MOTMutablePopView.m
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import "MOTMutablePopView.h"

typedef enum {
    POP_ARROW_TOP,
    POP_ARROW_DOWN,
    POP_ARROW_LEFT,
    POP_ARROW_RIGHT,
}POP_ARROW_DIRECTION;//箭头所在位置

@interface MOTMutablePopView ()
{
    CGFloat _h_mid_y;//横向的中间坐标
    CGFloat _h_pop_x;//横向的popx坐标
}

@property (copy, nonatomic) clickBlock clickBlock;
@property (strong, nonatomic) MOTPopConfig *config;
@property (nonatomic, assign) CGRect viewFrame;
@property (nonatomic, assign) POP_ARROW_DIRECTION arrow_direction;


@end

@implementation MOTMutablePopView

#pragma mark -宏

#pragma mark -懒加载

#pragma mark -系统
-(instancetype)init {
    if (self = [super init]) {
        [self setDefault];
    }
    
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isEqual:self]) {
        [self hidAlert];
    }
}
-(void)drawRect:(CGRect)rect {
    if (self.config.direction == POP_VERTICAL) {
        if (self.arrow_direction == POP_ARROW_TOP) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
            [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y)];
            [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f, self.viewFrame.origin.y - self.config.arrowheight)];
            [self.config.tabColor setFill];
            [path fill];
        }
        else if (self.arrow_direction == POP_ARROW_DOWN) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f - self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
            [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f + self.config.arrowWidth / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height)];
            [path addLineToPoint:CGPointMake(self.viewFrame.origin.x + self.viewFrame.size.width / 2.0f, self.viewFrame.origin.y + self.viewFrame.size.height + self.config.arrowheight)];
            [self.config.tabColor setFill];
            [path fill];
        }
    }
    else if (self.config.direction == POP_HORIZONTAL) {
        if (self.arrow_direction == POP_ARROW_LEFT) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_h_pop_x, _h_mid_y - self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x, _h_mid_y + self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x - self.config.arrowheight, _h_mid_y)];
            [self.config.tabColor setFill];
            [path fill];
        }
        else if (self.arrow_direction == POP_ARROW_RIGHT) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_h_pop_x + self.config.size.width, _h_mid_y - self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x + self.config.size.width, _h_mid_y + self.config.arrowWidth / 2.0f)];
            [path addLineToPoint:CGPointMake(_h_pop_x + self.config.size.width + self.config.arrowheight, _h_mid_y)];
            [self.config.tabColor setFill];
            [path fill];
        }
    }
}


#pragma mark -set方法
-(void)setConfig:(MOTPopConfig *)config {
    _config = config;
    
    UIImageView *view = [UIImageView new];
    view.alpha = 0.0f;
    view.userInteractionEnabled = YES;
    view.frame = [self judgePopViewFrameWithView:config.targetView];
    self.viewFrame = view.frame;
    view.image = config.backgroundImage;
    view.clipsToBounds = YES;
    view.layer.cornerRadius = config.cornerRadius;
    if (config.cornerRadius == 0.0f) {
        view.clipsToBounds = NO;
    }
    view.layer.shadowOffset = config.shadowOffset;
    view.layer.shadowOpacity = config.shadowOpacity;
    view.layer.shadowColor = config.shadowColor.CGColor;
    view.layer.shadowRadius = config.shadowRadius;
    
    view.backgroundColor = config.tabColor;
    [self addSubview:view];
    
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.15 animations:^{
        view.alpha = 1.0f;
        [mySelf setNeedsDisplay];
    }];
    
    for (int i = 0; i < config.views.count; i++) {
        UIView *tabView = config.views[i];
        tabView.frame = CGRectMake(0, i * (config.size.height / config.views.count), config.size.width, config.size.height / config.views.count);
        tabView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTabView:)];
        tabView.tag = i;
        [tabView addGestureRecognizer:tap];
        [view addSubview:tabView];
    }
}

#pragma mark -初始化
-(void)setDefault {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.userInteractionEnabled = YES;
}

#pragma mark -约束
-(void)addPopViewLayoutConstraint:(MOTMutablePopView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeLeft multiplier:1 constant:100];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeRight multiplier:1 constant:100];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeBottom multiplier:1 constant:100];
    
    [[UIApplication sharedApplication].keyWindow addConstraints:@[left, right, top, bottom]];
}

#pragma mark -私有
//隐藏
-(void)hidAlert {
    [self removeFromSuperview];
}
//获取view的屏幕相对坐标
-(CGRect)getScreenFramWithView:(UIView*) view {
    CGRect rect = [view convertRect:view.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    return rect;
}
-(CGRect)judgePopViewFrameWithView:(UIView*) view{
    CGRect screenFrame = [self getScreenFramWithView:view];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGRect rect;

    if (self.config.direction == POP_VERTICAL) {
        screenFrame = CGRectMake(screenFrame.origin.x + screenFrame.size.width / 2.0f - self.config.size.width / 2.0f, screenFrame.origin.y, screenFrame.size.width, screenFrame.size.height);
        
        //屏幕左上角
        if (screenFrame.origin.x < screenWidth / 2.0f && screenFrame.origin.y < screenHeight / 2.0f) {
            rect = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height + self.config.arrowheight + self.config.inset, self.config.size.width, self.config.size.height);
            rect = [self judgeLefToRect:rect];
            self.arrow_direction = POP_ARROW_TOP;
        }
        //屏幕右上角
        else if (screenFrame.origin.x > screenWidth / 2.0f && screenFrame.origin.y < screenHeight / 2.0f) {
            rect = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height + self.config.arrowheight + self.config.inset, self.config.size.width, self.config.size.height);
            rect = [self judgeRightToRect:rect ScreenWidth:screenWidth];
            self.arrow_direction = POP_ARROW_TOP;
        }
        //屏幕左下角
        else if (screenFrame.origin.x < screenWidth / 2.0f && screenFrame.origin.y > screenHeight / 2.0f) {
            rect = CGRectMake(screenFrame.origin.x, screenFrame.origin.y - self.config.size.height - self.config.arrowheight - self.config.inset, self.config.size.width, self.config.size.height);
            rect = [self judgeLefToRect:rect];
            self.arrow_direction = POP_ARROW_DOWN;
        }
        //屏幕右下角
        else if (screenFrame.origin.x > screenWidth / 2.0f && screenFrame.origin.y > screenHeight / 2.0f) {
            rect = CGRectMake(screenFrame.origin.x, screenFrame.origin.y - self.config.size.height - self.config.arrowheight - self.config.inset, self.config.size.width, self.config.size.height);
            rect = [self judgeRightToRect:rect ScreenWidth:screenWidth];
            self.arrow_direction = POP_ARROW_DOWN;
        }
    }
    else if (self.config.direction == POP_HORIZONTAL) {
        CGFloat midHeight = self.config.size.height / (self.config.views.count == 0 || self.config.views.count == 1 ? 2.0f : 2.0f * self.config.views.count);
        
        //屏幕左上角
        if (screenFrame.origin.x < screenWidth / 2.0f && screenFrame.origin.y < screenHeight / 2.0f) {
            screenFrame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height / 2.0f - midHeight, screenFrame.size.width, screenFrame.size.height);
            rect = CGRectMake(screenFrame.origin.x + screenFrame.size.width + self.config.arrowheight + self.config.inset, screenFrame.origin.y, self.config.size.width, self.config.size.height);
            rect = [self judgeTopToRect:rect];
            self.arrow_direction = POP_ARROW_LEFT;
            _h_mid_y = rect.origin.y + midHeight;
        }
        //屏幕右上角
        else if (screenFrame.origin.x > screenWidth / 2.0f && screenFrame.origin.y < screenHeight / 2.0f) {
            screenFrame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height / 2.0f - midHeight, screenFrame.size.width, screenFrame.size.height);
            rect = CGRectMake(screenFrame.origin.x - self.config.size.width - self.config.arrowheight - self.config.inset, screenFrame.origin.y, self.config.size.width, self.config.size.height);
            rect = [self judgeTopToRect:rect];
            self.arrow_direction = POP_ARROW_RIGHT;
            _h_mid_y = rect.origin.y + midHeight;
        }
        //屏幕左下角
        else if (screenFrame.origin.x < screenWidth / 2.0f && screenFrame.origin.y > screenHeight / 2.0f) {
            screenFrame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height / 2.0f - self.config.size.height + midHeight, screenFrame.size.width, screenFrame.size.height);
            rect = CGRectMake(screenFrame.origin.x + screenFrame.size.width + self.config.arrowheight + self.config.inset, screenFrame.origin.y, self.config.size.width, self.config.size.height);
            rect = [self judgeBottomToRect:rect ScreenHeight:screenHeight];
            self.arrow_direction = POP_ARROW_LEFT;
            _h_mid_y = rect.origin.y + rect.size.height - midHeight;
        }
        //屏幕右下角
        else if (screenFrame.origin.x > screenWidth / 2.0f && screenFrame.origin.y > screenHeight / 2.0f) {
            screenFrame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height / 2.0f - self.config.size.height + midHeight, screenFrame.size.width, screenFrame.size.height);
            rect = CGRectMake(screenFrame.origin.x - self.config.size.width - self.config.arrowheight -self.config.inset, screenFrame.origin.y, self.config.size.width, self.config.size.height);
            rect = [self judgeBottomToRect:rect ScreenHeight:screenHeight];
            self.arrow_direction = POP_ARROW_RIGHT;
            _h_mid_y = rect.origin.y + rect.size.height - midHeight;
        }
        
        _h_pop_x = rect.origin.x;
    }
    
    return rect;
}
-(CGRect)judgeLefToRect:(CGRect) rect{
    //超过屏幕左侧
    if (rect.origin.x < 0) {
        rect = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeRightToRect:(CGRect) rect ScreenWidth:(CGFloat) screenWidth {
    //超过屏幕右侧
    if (rect.origin.x + rect.size.width > screenWidth) {
        rect = CGRectMake(screenWidth - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeTopToRect:(CGRect) rect{
    //超过屏幕上侧
    if (rect.origin.y < 0) {
        rect = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
    }
    
    return rect;
}
-(CGRect)judgeBottomToRect:(CGRect) rect ScreenHeight:(CGFloat) screenHeight {
    //超过屏幕下侧
    if (rect.origin.y + rect.size.height > screenHeight) {
        rect = CGRectMake(rect.origin.x, screenHeight - rect.size.height, rect.size.width, rect.size.height);
    }
    
    return rect;
}

#pragma mark -公共
+(void)popWithConfig:(MOTPopConfig *)config ClickIndexBlock:(clickBlock)clickBlock {
    MOTMutablePopView *popView = [self new];
    popView.config = config;
    popView.clickBlock = clickBlock;
    
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    [popView addPopViewLayoutConstraint:popView];
}

#pragma mark -点击事件
-(void)tapTabView:(UITapGestureRecognizer*) gr {
    
    if (self.clickBlock) {
        self.clickBlock(gr.view.tag);
    }
    
    [self hidAlert];
}

#pragma mark -销毁
-(void)dealloc {
    NSLog(@"MOTMutablePopView销毁了");
}

@end
