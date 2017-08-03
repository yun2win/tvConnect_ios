//
//  Y2WTVModel.h
//  Y2W_ConnetcionTV_SDK
//
//  Created by 段洪亮 on 2017/7/26.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Y2WTVModel : NSObject <NSCoding>

//用户id
@property (nonatomic, strong) NSString  *ID;

//品牌
@property (nonatomic, strong) NSString  *brand;

//连接者id
@property (nonatomic, strong) NSString  *connector;

//型号
@property (nonatomic, strong) NSString  *model;

//状态
@property (nonatomic, strong) NSString  *state;

//名称
@property (nonatomic, strong) NSString  *name;

@end
