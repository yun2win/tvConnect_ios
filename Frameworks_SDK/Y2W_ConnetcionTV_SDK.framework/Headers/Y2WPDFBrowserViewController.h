//
//  Y2WPDFBrowserViewController.h
//  Y2W_ConnetcionTV_SDK
//
//  Created by 段洪亮 on 2017/7/27.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Y2WPDFBrowserViewController : UIViewController

/**
 *  PDF画廊
 *
 *  @param PDFUrl       pdf文件Url
 *  @param curIndex     当前需要显示第几页
 */
- (instancetype)initWithPDFUrl:(NSURL *)PDFUrl curIndex:(NSUInteger)curIndex;

@end
