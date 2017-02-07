//
//  AppDelegate.m
//  引导页
//
//  Created by 唐明明 on 16/5/19.
//  Copyright © 2016年 唐明明. All rights reserved.
//

#import "AppDelegate.h"
#import "TMM_NewfeaturesController.h"

@interface AppDelegate ()

/**
 *  默认根视图
 */
@property(nonatomic,strong)UIViewController *defaultRootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //保存原本的rootVC
    self.defaultRootVC = self.window.rootViewController;
    
    __weak AppDelegate *temp = self;
    TMM_NewfeaturesController *welcomeVC  = [TMM_NewfeaturesController
                                             createWithImageNames:@[@"1",@"2",@"3"]
                                                    CompleteTitle:@"立即体验"
                                                            Frame:self.window.bounds
                                                         Complete:^{
                                                           //切换回主页面
                                                           [temp.window setRootViewController:temp.defaultRootVC];
                                                          }];
    //设置新特性页面为rootVC
    [self.window setRootViewController:welcomeVC];
    
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
