//
//  SecurityUtils.h
//
//  Created by Ning Gang on 14-4-15.
//  Copyright (c) 2014年 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtils : NSObject

/*!
 @method
 @abstract   SHA1WithRSA
 @discussion 字符串签名，签名方式SHA1WithRSA
 @param      pemFilePath pem密钥文件
 @param      content 签名原数据
 @result     签名后的字符串
 */
+ (NSString *)RSASign:(NSString *)pemFilePath Content:(NSData *)content;

/*!
 @method
 @abstract   SHA1WithRSA
 @discussion 字符串签名，签名方式SHA1WithRSA
 @param      privateKey 私钥字符串
 @param      originString 签名原字符串
 @result     签名后的字符串
 */
+ (NSString *)RSASignWithPrivateKey:(NSString *)privateKey originString:(NSString *)originString;

/*!
 @method
 @abstract   转换密钥格式
 @discussion 将私钥字符串转为pem文件字符串
 @param      privateKey 私钥字符串
 @result     pem文件字符串
 */
+ (NSString *)formatPrivateKey:(NSString *)privateKey;

@end
