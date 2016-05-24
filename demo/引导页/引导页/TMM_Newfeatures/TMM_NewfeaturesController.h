//
//  WelcomeViewController.h
//
//  欢迎页面
//  Created by Methodname  on 14-12-8.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelcomeDelegate <NSObject>

/**
 *  完成方法
 */
-(void)welcomeOK;

@end


@interface TMM_NewfeaturesController : UIViewController<UIScrollViewDelegate>

/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createTMM_NewfeaturesController:(NSArray *)imageNames
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
+(TMM_NewfeaturesController *)createTMM_NewfeaturesController:(NSArray *)imageNames
                                                CompleteTitle:(NSString *)title
                                             CompleteDelegate:(id<WelcomeDelegate>)delegate;

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
+(TMM_NewfeaturesController *)createTMM_NewfeaturesController:(NSArray *)imageNames
                                                CompleteTitle:(NSString *)title
                                             CompleteDelegate:(id<WelcomeDelegate>)delegate Frame:(CGRect)frame;



/**
 *  代理
 */
@property(nonatomic,weak)id<WelcomeDelegate>completeDelegate;

/**
 *  图片名字数组
 */
@property(nonatomic,strong) NSArray *imageNames;
/**
 *  完成按钮
 */
@property(nonatomic,weak)UIButton * completeBtn;


@property (nonatomic,strong) UIViewController * presentVC;

@end
