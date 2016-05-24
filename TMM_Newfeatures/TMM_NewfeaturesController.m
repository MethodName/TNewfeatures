//
//  TMM_NewfeaturesController.m
//  
//
//  Created by Methodname on 14-12-8.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "TMM_NewfeaturesController.h"
#import "AppDelegate.h"

#pragma mark -欢迎界面
@interface TMM_NewfeaturesController ()

/**
 *  page
 */
@property(nonatomic,strong) UIPageControl * pageControl;

/**
 *  图片数组
 */
@property(nonatomic,strong)NSMutableArray *imageArray;


@end

//获取屏幕 宽度、高度
#define DV_W ([UIScreen mainScreen].bounds.size.width)
#define DV_H ([UIScreen mainScreen].bounds.size.height)

//延迟GCD时间
#define DisTime(time)  dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC)
//延迟GCD
#define DisBACK(disTime,block) dispatch_after(disTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){dispatch_async(dispatch_get_main_queue(), block);});

#define kNotificationWelcomeOk @"_kNotificationWelcomeOk"

@implementation TMM_NewfeaturesController


/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createTMM_NewfeaturesController:(NSArray *)imageNames
                                                completeTitle:(NSString *)title
{
    TMM_NewfeaturesController * vc = [[TMM_NewfeaturesController alloc]init];
    [vc setImageNames:imageNames];
    [vc.completeBtn setTitle:title forState:UIControlStateNormal];
    return vc;
}

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
                                             CompleteDelegate:(id<WelcomeDelegate>)delegate
{
    TMM_NewfeaturesController * vc = [[TMM_NewfeaturesController alloc]init];
    [vc setImageNames:imageNames];
    [vc.completeBtn setTitle:title forState:UIControlStateNormal];
    [vc setCompleteDelegate:delegate];
    return vc;
}

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
                                             CompleteDelegate:(id<WelcomeDelegate>)delegate Frame:(CGRect)frame
{
    TMM_NewfeaturesController * vc = [[TMM_NewfeaturesController alloc]init];
    [vc setImageNames:imageNames];
    [vc.completeBtn setTitle:title forState:UIControlStateNormal];
    [vc.view setFrame:frame];
    [vc setCompleteDelegate:delegate];
    return vc;
}





/**
 *  设置图片数组
 *
 *  @param imageNames 图片数组
 */
-(void)setImageNames:(NSMutableArray *)imageNames
{
    _imageNames = imageNames;
    [self initialize];
}



/**
 *  初始化数据
 */
-(void)initialize
{
    CGRect viewFrame = self.view.bounds;
    
    //scrollView
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.delegate = self;
    sv.frame = self.view.frame;
    sv.contentSize = CGSizeMake(viewFrame.size.width*self.imageNames.count
                                , viewFrame.size.height);
    
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.bounces = NO;
     self.imageArray = [NSMutableArray new];
    
    UIImageView *lastImg = nil;
    for (int i = 0 ; i < self.imageNames.count; i ++)
    {
        
        UIImageView *imgView =
        [
            [UIImageView alloc] initWithImage:
            [
                UIImage imageNamed:self.imageNames[i]
            ]
        ];
        
        imgView.frame = CGRectMake(i*viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height);
        
        [sv addSubview:imgView];
        [self.imageArray addObject:imgView];
        lastImg = imgView;
    }
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(lastImg.frame.origin.x, 0, viewFrame.size.width-32, 44);
     btn.center = CGPointMake(lastImg.frame.origin.x+viewFrame.size.width/2, viewFrame.size.height - btn.frame.size.height/2-30);
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    
    self.completeBtn = btn;
    
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setHidden:YES];
    [sv addSubview:btn];
    
 
    
    UIPageControl *page = [[UIPageControl alloc] init];
    page.frame = CGRectMake(0,
                            self.view.bounds.size.height-self.bottomLayoutGuide.length-30,
                            self.view.bounds.size.width,
                            20);
    
    page.numberOfPages =self.imageNames.count;
    page.userInteractionEnabled = NO;
    
    page.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    page.pageIndicatorTintColor = [UIColor colorWithRed:(200.0/255.0f) green:(200.0/255.0f) blue:(200.0/255.0f) alpha:0.5f];

    self.pageControl = page;
    [self.view addSubview:sv];
    
    [self.view addSubview:page];
 }

/**
 *  scrollView拖动代理事件
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //偏移图片处理
    NSInteger index =scrollView.contentOffset.x/self.view.frame.size.width;
    if (index<2) {
        UIImageView *image1 = self.imageArray[index];
        UIImageView *image2 = self.imageArray[index+1];
        [image1 setFrame:CGRectMake(scrollView.contentOffset.x, 0, DV_W-(scrollView.contentOffset.x-DV_W*index), DV_H)];
        [image2 setFrame:CGRectMake(image1.frame.origin.x+image1.frame.size.width, 0, DV_W-image1.frame.size.width, DV_H)];
        
    }
    
    //显示按钮
    __weak TMM_NewfeaturesController *temp = self;
    self.pageControl.currentPage =  index;
    DisBACK(DisTime(0.5),^{
        [temp.completeBtn setHidden:!(temp.pageControl.numberOfPages-1 == index)];
    });
    //隐藏Page
    [self.pageControl setHidden:(self.pageControl.numberOfPages-1 == index)];
}



/**
 *  完成按钮点击
 */
-(void) btnClick
{
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:kNotificationWelcomeOk object:nil];
    
    [self.completeDelegate welcomeOK];
    
}





@end
