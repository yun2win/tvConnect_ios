//
//  AppDelegate.h
//  Y2W_SDK_test
//
//  Created by 段洪亮 on 2017/7/28.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Y2W_ConnetcionTV_SDK/Y2W_ConnetcionTV_SDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) Y2WConnetcion      *connetcion;
@property (nonatomic, assign) BOOL                isConnetcion;     //是否连接成功

@end

