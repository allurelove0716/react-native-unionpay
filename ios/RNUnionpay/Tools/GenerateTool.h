//
//  GenerateTool.h
//  testDEMO
//
//  Created by chinaums on 15/10/27.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GenerateTool : NSObject

+ (NSDictionary *)generateMerchantInfoWithMerchantId:(NSString *)merchantId;
+ (NSDictionary *)generateMerchantInfoWithMerchantId:(NSString *)merchantId agentMerchantId:(NSString *)agentMerchantId;

+ (NSString *)generateMerOrderId;

+ (NSString *)fenFromYuan:(NSString *)yuan;

@end
