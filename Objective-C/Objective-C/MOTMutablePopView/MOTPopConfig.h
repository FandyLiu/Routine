//
//  MOTPopConfig.h
//  MOTSegmentedControl
//
//  Created by 牛帮主 on 17/2/8.
//  Copyright © 2017年 牛帮主. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    POP_VERTICAL,//竖向，箭头朝上或朝下
    POP_HORIZONTAL,//横向，箭头朝左或朝右
}POP_DIRECTION;//pop的方向

@interface MOTPopConfig : NSObject

//选项卡颜色，默认颜色，灰色
@property (strong, nonatomic) UIColor *tabColor;
//背景图片
@property (strong, nonatomic) UIImage *backgroundImage;
//选项卡大小
@property (assign, nonatomic) CGSize size;
//pop方向，默认为竖向
@property (assign, nonatomic) POP_DIRECTION direction;
//圆角，默认5
@property (assign, nonatomic) CGFloat cornerRadius;
//阴影
@property (assign, nonatomic) CGFloat shadowRadius;
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) float shadowOpacity;
@property (assign, nonatomic) CGSize shadowOffset;

//目标view，即是哪个view弹出菜单的
@property (weak, nonatomic) UIView *targetView;
//箭头宽高，默认宽20，高10
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowheight;

//箭头与目标之间的距离，默认为0
@property (assign, nonatomic) CGFloat inset;

//选项卡中以下标形式存在的选项数组
@property (strong, nonatomic, readonly) NSArray <UIView*>*views;

//添加选项
-(void)addView:(UIView*) view;

//删除特定下标的选项
-(void)removeTabWithIndex:(NSUInteger) index;

//删除所有选项
-(void)removeAllTab;

@end
