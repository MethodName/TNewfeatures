//
//  UIViewController+Swizzling.m
//  引导页
//
//  Created by 唐明明 on 16/5/20.
//  Copyright © 2016年 唐明明. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#include <objc/runtime.h>

#include <Foundation/NSObjCRuntime.h>


@implementation UIViewController (Swizzling)

+(void)load
{
    NSLog(@"Swizzling+load");
    //获取要替换的方法
    Method  frommethod = class_getClassMethod([self class], @selector(viewDidLoad));
    //获取要替换成的方法
    Method tomethod = class_getClassMethod([self class], @selector(swizzlingViewDidLoad));
    
    
    
//    *  IMP imp1 = method_getImplementation(m1);
//    *  IMP imp2 = method_getImplementation(m2);
//    *  method_setImplementation(m1, imp2);
//    *  method_setImplementation(m2, imp1);
    
    
    //判断要替换的方法在当前类中有没有实现
   if(!class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(tomethod), method_getTypeEncoding(tomethod)))
   {
       //替换方法
       method_exchangeImplementations(frommethod, tomethod);
       NSLog(@"method_exchangeImplementations");
   }
}


-(void)swizzlingViewDidLoad
{
    NSLog(@"SwizzlingViewDidLoad");
    [self swizzlingViewDidLoad];
}

@end
