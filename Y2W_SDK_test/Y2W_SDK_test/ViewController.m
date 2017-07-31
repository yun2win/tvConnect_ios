//
//  ViewController.m
//  Y2W_SDK_test
//
//  Created by 段洪亮 on 2017/7/28.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import "ViewController.h"
#import <Y2W_ConnetcionTV_SDK/Y2W_ConnetcionTV_SDK.h>
#import "CustomizeViewController.h"

@interface ViewController ()

@property (nonatomic, strong)Y2WConnetcion      *connetcion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //注销当前IM连接
    [self.connetcion logoutIM];
}


#pragma mark 按钮点击事件
- (IBAction)defaultUIAction:(UIButton *)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i++) {
        NSString *urlStr = @"http://imgsrc.baidu.com/imgad/pic/item/b03533fa828ba61e5e6d4c0d4b34970a304e5915.jpg";//;@"https://nr-platform.s3.amazonaws.com/uploads/platform/published_extension/branding_icon/275/AmazonS3.png";
        NSURL *url = [NSURL URLWithString:urlStr];
        [array addObject:url];
    }
    
    //连接IM
    Y2WConnetcion *connetcion = [[Y2WConnetcion alloc] initWithAppkey:@"pcDeF3PT63XYAlvm" appSecret:@"CsFJameMf3eQUCzT4ERbOzCh" uid:@"108" userName:@"测试1" userAvatarUrl:@"" result:^(NSError *error) {

        Y2WImageBrowserViewController *imageVc = [[Y2WImageBrowserViewController alloc] initWithImageArray:[array copy] curIndex:0];
        [self presentViewController:imageVc animated:YES completion:nil];

    }];
    self.connetcion = connetcion;
    
}

- (IBAction)customizeUIAction:(UIButton *)sender {
    CustomizeViewController *customizeVc = [[CustomizeViewController alloc] init];
    [self presentViewController:customizeVc animated:YES completion:nil];
}

@end
