//
//  ScanQRcode.m
//  QRcode_GHdemo
//
//  Created by xiangwang on 16/6/28.
//  Copyright © 2016年 Hope. All rights reserved.
//

#import "ScanQRcode.h"

#define kImageW 0.3f
#define kImageH 0.3f
#define GH_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define GH_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@interface ScanQRcode ()

@end

@implementation ScanQRcode

- (void)dealloc {
    [self invalidateTimer];

}

- (void)invalidateTimer {
    [timer invalidate];
    timer = nil;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"扫一扫";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(100, 430, GH_WIDTH-200, 50);
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
    _device = [ AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input = [ AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [[ AVCaptureMetadataOutput alloc]init];
    [ _output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[ AVCaptureSession alloc]init];
    [ _session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([ _session canAddInput:self.input])
    {
        [ _session addInput:self.input];
    }
    if ([ _session canAddOutput:self.output])
    {
        [ _session addOutput:self.output];
    }
    
    CGFloat imageX = (GH_WIDTH - (GH_WIDTH - GH_WIDTH * kImageW)) / 2.0f;
    CGFloat imageY = GH_HEIGHT * kImageH;
    CGFloat imageW = GH_WIDTH- GH_WIDTH * kImageW;
    CGFloat imageH = GH_WIDTH-GH_WIDTH * kImageW;
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [_output setRectOfInterest : CGRectMake (imageY / GH_HEIGHT, imageX / GH_WIDTH, imageH / GH_HEIGHT, imageW / GH_WIDTH)];

    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    //    _preview.tor
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    //扫描框
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    upOrdown = NO;
    num =0;
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, imageY + imageH, GH_WIDTH, 50.0f)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.font = [UIFont systemFontOfSize:14.0f];
    labIntroudction.numberOfLines = 2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text=@"将二维码放到框内，即可自动识别";
    [self.view addSubview:labIntroudction];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, 1.0f)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [ _session startRunning ];
}
#pragma mark -
#pragma mark - 上下动画
-(void)animation1
{
    CGFloat imageX = (GH_WIDTH - (GH_WIDTH - GH_WIDTH * kImageW)) / 2.0f;
    CGFloat imageY = GH_HEIGHT * kImageH;
    
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(imageX, imageY + 2.0f * num, imageView.frame.size.width, 2.0f);
        if (2*num > GH_WIDTH-GH_WIDTH * kImageW - 5.0f) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(imageX, imageY + 2.0f * num, imageView.frame.size.width, 2.0f);
        if (num == 2) {
            upOrdown = NO;
        }
    }
    
}
#pragma mark -
#pragma mark - 取消按钮
-(void)backAction
{
    _line.hidden = NO;
    [ _session startRunning ];
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection {
    
    NSString *stringValue;
    if ([metadataObjects count] > 0 )
    {
        // 停止扫描
        [ _session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        _line.hidden = YES;//隐藏动画效果
        if (stringValue && stringValue.length > 0) {
            if (self.scanResult) {
                self.scanResult(stringValue);
            }
            
            [self back];
        }
    }
}

- (void)alert {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"扫描失败,请确认二维码是否有效" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 重新扫描
        [ _session startRunning];
        _line.hidden = NO;
    }];
    
    [alertVc addAction:OKAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)back
{
    [self invalidateTimer];
    
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
