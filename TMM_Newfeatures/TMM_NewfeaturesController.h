//
//  WelcomeViewController.h
//
//  欢迎页面
//  Created by Methodname  on 14-12-8.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>


//获取屏幕 宽度、高度
#define DV_W ([UIScreen mainScreen].bounds.size.width)
#define DV_H ([UIScreen mainScreen].bounds.size.height)
//CompleteBtn显示动画时长
#define AnimateDuration 0.5f
//CompleteBtn开始显示等待时间
#define AnimateDelay 0.25f
//CompleteBtn标题颜色
#define CompleteBtnTitleColor [UIColor whiteColor]
//CompleteBtn背景颜色
#define CompleteBtnBackgroundColorr [UIColor orangeColor]
//CompleteBtn圆角
#define CompleteBtnCornerRadius 5.0f
//page当前指示显示颜色
#define CurrentPageIndicatorTintColor [UIColor orangeColor]
//page默认显示颜色
#define PageIndicatorTintColor [UIColor colorWithRed:(200.0/255.0f) green:(200.0/255.0f) blue:(200.0/255.0f) alpha:0.5f]

/**
 完成按钮点击回调block
 */
typedef void (^CompleteClick)();


@interface TMM_NewfeaturesController : UIViewController<UIScrollViewDelegate>

/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
                                     completeTitle:(NSString *)title;

/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *  @param delegate   完成代理对象
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
                                     CompleteTitle:(NSString *)title
                                          Complete:(CompleteClick)complete;

/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *  @param delegate   完成代理对象
 *  @param frame      视图范围
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
                                     CompleteTitle:(NSString *)title
                                             Frame:(CGRect)frame
                                          Complete:(CompleteClick)complete;


/**
 *  图片名字数组
 */
@property(nonatomic,strong) NSArray *imageNames;
/**
 *  完成按钮
 */
@property(nonatomic,weak)UIButton * completeBtn;


@end
