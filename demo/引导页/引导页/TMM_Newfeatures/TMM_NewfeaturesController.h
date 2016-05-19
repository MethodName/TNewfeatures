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
