//
//  WelcomeViewController.m
//  
//
//  Created by Methodname on 14-12-8.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "TMM_NewfeaturesController.h"

@interface TMM_NewfeaturesController ()

/**
 *  page
 */
@property(nonatomic,strong) UIPageControl * pageControl;

/**
 *  图片数组
 */
@property(nonatomic,strong)NSMutableArray *imageArray;

/**
 完成按钮回调block
 */
@property(nonatomic,copy)CompleteClick completeBtnclick;

@end



@implementation TMM_NewfeaturesController


/**
 *  创建一个实例
 *
 *  @param imageNames 图片名字数组
 *  @param title      完成按钮标题
 *
 *  @return 实例对象
 */
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
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
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
                                                CompleteTitle:(NSString *)title
                                             Complete:(CompleteClick)complete
{
    TMM_NewfeaturesController * vc = [[TMM_NewfeaturesController alloc]init];
    [vc setImageNames:imageNames];
    [vc.completeBtn setTitle:title forState:UIControlStateNormal];
    vc.completeBtnclick = complete;
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
+(TMM_NewfeaturesController *)createWithImageNames:(NSArray *)imageNames
                                                CompleteTitle:(NSString *)title
                                                        Frame:(CGRect)frame
                                                     Complete:(CompleteClick)complete
{
    TMM_NewfeaturesController * vc = [[TMM_NewfeaturesController alloc]init];
    [vc setImageNames:imageNames];
    [vc.completeBtn setTitle:title forState:UIControlStateNormal];
    [vc.view setFrame:frame];
    vc.completeBtnclick = complete;
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
    
    //complete按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(lastImg.frame.origin.x, 0, viewFrame.size.width-32, 44);
    btn.center = CGPointMake(lastImg.frame.origin.x+viewFrame.size.width/2, viewFrame.size.height - btn.frame.size.height/2-30);
    btn.backgroundColor = CompleteBtnBackgroundColorr;
    [btn setTitleColor:CompleteBtnTitleColor forState:0];
    
    btn.layer.cornerRadius = CompleteBtnCornerRadius;
    [btn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sv addSubview:btn];
    self.completeBtn = btn;
 
    
    //page
    UIPageControl *page = [[UIPageControl alloc] init];
    page.frame = CGRectMake(0,
                            self.view.bounds.size.height-self.bottomLayoutGuide.length-30,
                            self.view.bounds.size.width,
                            20);
    
    page.numberOfPages =self.imageNames.count;
    page.userInteractionEnabled = NO;
    
    page.currentPageIndicatorTintColor = CurrentPageIndicatorTintColor;
    page.pageIndicatorTintColor = PageIndicatorTintColor;
    [self.view addSubview:sv];
    [self.view addSubview:page];
    
    
    self.pageControl = page;
    
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
    if (index<self.imageArray.count-1)
    {
        UIImageView *image1 = self.imageArray[index];
        UIImageView *image2 = self.imageArray[index+1];
        [image1 setFrame:CGRectMake(scrollView.contentOffset.x, 0, DV_W-(scrollView.contentOffset.x-DV_W*index), DV_H)];
        [image2 setFrame:CGRectMake(image1.frame.origin.x+image1.frame.size.width, 0, DV_W-image1.frame.size.width, DV_H)];
        
    }
    
    //显示按钮
    self.pageControl.currentPage =  index;
    //当前下标为最后一页
    if (self.pageControl.numberOfPages-1 == index)
    {
        //显示按钮
        [UIView animateWithDuration:AnimateDuration delay:AnimateDelay options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.completeBtn setAlpha:1.0f];
        } completion:nil];
    }
    else
    {
        //隐藏按钮
        [self.completeBtn setAlpha:0.0];
    }
}



/**
 *  完成按钮点击
 */
-(void)completeBtnClick
{
    //执行外部传入的block
    if (self.completeBtnclick)
    {
        self.completeBtnclick();
    }
}





@end
