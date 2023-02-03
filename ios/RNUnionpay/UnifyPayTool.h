//
//  UnifyPayTool.h
//  testDEMO
//
//  Created by SunXP on 17/5/8.
//  Copyright © 2017年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnifyPayTool : NSObject

// 获取当前时间
+ (NSString *)getCurrentDate;

// 根据订单前四位生成订单号
+ (NSString *)getOrderIDWithMsgSrcId:(NSString *)msgSrcId;

// 生成支付物品详情
+ (NSString *)getGoodsDescription;

// 数据签名
+ (NSString *)getSign:(NSDictionary *)dataDic MD5Key:(NSString *)MD5Key;

// MD5加密算法
+ (NSString *)md5:(NSString *)str;

// 数据SHA256签名
+ (NSString *)getSHA256Sign:(NSDictionary *)dataDic MD5Key:(NSString *)MD5Key;

//SHA256 加密算法
+ (NSString *)SHA256WithString:(NSString *)inputString;

// 添加菊花
+ (void)showHUD:(UIView *)targetView animated:(BOOL)animated;

// 隐藏菊花
+ (void)hideHUD:(UIView *)targetView animated:(BOOL)animated;

// 获取设备UUID
+ (NSString *)getUUID;
@end
