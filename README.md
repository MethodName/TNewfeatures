# TMM_Newfeatures

#效果

![img](https://github.com/MethodName/TMM_Newfeatures/blob/master/2016-05-19%2011_43_22.gif)



#【2.0版本】使用更加简洁
```objc

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
    

```

#备注
关于具体的使用方法可以查看demo





