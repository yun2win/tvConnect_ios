//
//  Y2WConnetcion.h
//  Y2W_ConnetcionTV_SDK
//
//  Created by 段洪亮 on 2017/7/24.
//  Copyright © 2017年 yun2win. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Y2WTVModel;

@interface Y2WConnetcion : NSObject

/**
 *  实例化并连接IM
 *
 *  @param appKey           appKey
 *  @param appSecret        appSecret
 *  @param uid              IM通信的唯一标识
 *  @param userName         用户名
 *  @param userAvatarUrl    用户头像
 *  @param result           返回的结果 error == nil 表示操作成功
 */
- (instancetype)initWithAppkey:(NSString *)appKey appSecret:(NSString *)appSecret uid:(NSString *)uid userName:(NSString *)userName userAvatarUrl:(NSString *)userAvatarUrl result:(void (^)(NSError *error))result;

/**
 *  注销或断开当前IM用户连接
 *
 */
- (void)logoutIM;


/**
 *  扫描电视二维码
 *
 *  @param scanStr          扫描到的原始字符串 
 *  AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
 *  NSString *scanStr = metadataObject.stringValue;
 *
 *  @param result           error==nil 并且 tvModel !=nil 表示数据解析成功
 */
- (void)scanQRcodeTvStr:(NSString *)scanStr result:(void (^)(Y2WTVModel *tvModel, NSError *error))result;

/**
 *  获取本地保存的电视 (需配合 saveTvModel:方法一起用)
 *
 *  返回 Y2WTVModel的数组
 */
- (NSArray<Y2WTVModel *> *)getAllTvList;

/**
 *  保存电视到本地
 *
 *  @param tvModel           电视数据模型
 */
- (void)saveTvModel:(Y2WTVModel *)tvModel;

/**
 *  删除电视
 *
 *  @param tvId             电视的ID
 */
- (void)deleteTv:(NSString *)tvId;

/**
 *  PDF文件投屏到电视
 *
 *  @param url              文件的URL
 *  @param position         当前要显示第几页
 *  @param totalPageNum     pdf文档总页数
 *  @param fileName         文件名
 *  @param tvId             电视的ID
 */
- (void)tvPlayPDFUrl:(NSURL *)url position:(NSInteger)position totalPageNum:(NSInteger)totalPageNum fileName:(NSString *)fileName tvId:(NSString *)tvId;

/**
 *  图片投屏到电视
 *
 *  @param urls             图片url数组（建议一次传三张），电视默认显示数组的第一张图片，第二和第三张为电视端预加载，以提高电视端图片显示速度
 *  @param tvId             电视的ID
 */
- (void)tvPlayImageUrls:(NSArray<NSURL *> *)urls tvId:(NSString *)tvId;

/**
 *  电视端缩放显示
 *
 *  @param rect             rect为图片或者文件显示的相对位置和大小
 *  @param tvId             电视的ID
 */
- (void)tvScaleRect:(CGRect)rect tvId:(NSString *)tvId;

@end
