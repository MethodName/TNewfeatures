//
//  ViewController.m
//  引导页
//
//  Created by 唐明明 on 16/5/19.
//  Copyright © 2016年 唐明明. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

+(void)load
{
    [super load];
    NSLog(@"ViewController+load");
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
//    [self swizzlingViewDidLoad];
    
}

@end
