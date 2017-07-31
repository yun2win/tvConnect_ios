//
//  Y2WImageBrowserViewController.h
//  Y2W_ConnetcionTV_SDK
//
//  Created by 段洪亮 on 2017/7/27.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Y2WImageBrowserViewController : UIViewController

/**
 *  图片画廊
 *
 *  @param imageArray   图片Url数组
 *  @param curIndex     当前需要显示第几页
 */
- (instancetype)initWithImageArray:(NSArray<NSURL *> *)imageArray curIndex:(NSUInteger)curIndex;

@end
