//
//  CustomizeViewController.m
//  Y2W_SDK_test
//
//  Created by 段洪亮 on 2017/7/28.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import "CustomizeViewController.h"
#import <Y2W_ConnetcionTV_SDK/Y2W_ConnetcionTV_SDK.h>
#import "ScanQRcode.h"
#import "AppDelegate.h"

@interface CustomizeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView    *tableView;

@property (nonatomic, strong) Y2WConnetcion         *connetcion;
@property (nonatomic, strong) NSMutableArray        *tvArray;

@end

@implementation CustomizeViewController

- (NSMutableArray *)tvArray {
    if (_tvArray == nil) {
        _tvArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _tvArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.connetcion = app.connetcion;
    
    if (app.isConnetcion) {
        NSArray *tvArray = [self.connetcion getAllTvList];
        [self.tvArray addObjectsFromArray:[tvArray copy]];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tvArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    Y2WTVModel *model = self.tvArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Y2WTVModel *model = self.tvArray[indexPath.row];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 3; i++) {
        NSString *urlStr = @"http://imgsrc.baidu.com/imgad/pic/item/b03533fa828ba61e5e6d4c0d4b34970a304e5915.jpg";
        NSURL *url = [NSURL URLWithString:urlStr];
        [array addObject:url];
    }
    
    [self.connetcion tvPlayImageUrls:[array copy] tvId:model.ID];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)scan:(UIButton *)sender {
    ScanQRcode *scanVc = [[ScanQRcode alloc] init];
    [scanVc setScanResult:^(NSString *str){
        [self.connetcion scanQRcodeTvStr:str result:^(Y2WTVModel *tvModel, NSError *error) {
            if (tvModel && !error) {
                [self.connetcion saveTvModel:tvModel];
                [self.tvArray removeAllObjects];
                NSArray *tvArray = [self.connetcion getAllTvList];
                [self.tvArray addObjectsFromArray:[tvArray copy]];
                
                [self.tableView reloadData];
            }
        }];
    }];
    
    [self presentViewController:scanVc animated:YES completion:nil];
}

@end
