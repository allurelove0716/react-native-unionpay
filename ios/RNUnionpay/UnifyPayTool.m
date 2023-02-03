//
//  UnifyPayTool.m
//  testDEMO
//
//  Created by SunXP on 17/5/8.
//  Copyright © 2017年 L. All rights reserved.
//

#import "UnifyPayTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"

@implementation UnifyPayTool
+ (NSString *)getCurrentDate {
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    return currentDateStr;
}

+ (NSString *)getOrderIDWithMsgSrcId:(NSString *)msgSrcId {
    
    // 生成28位随机数
    static int kNumber = 28;
    NSString *sourceStr = @"0123456789";
    NSMutableString *randomStr = [[NSMutableString alloc] init];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
    srand(time(0)); // 此行代码有警告:
#pragma clang diagnostic pop
    for (int i = 0; i < kNumber; i++) {
        NSInteger index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [randomStr appendString:oneStr];
    }
    
    // 拼接系统编号作为订单号的前四位
    NSString *resultStr = [msgSrcId stringByAppendingString:randomStr];
    return resultStr;
}

+ (NSString *)getGoodsDescription {
    
    NSDictionary *descriptionDic = @{@"goodsId":@"666666",@"goodsName":@"unify测试商品",@"quantity":@"1",@"price":@"1",@"goodsCategory":@"测试商品分类",@"body":@"测试商品说明"};
    NSData *descriptionData = [NSJSONSerialization dataWithJSONObject:descriptionDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *tempStr = [[NSString alloc] initWithData:descriptionData encoding:NSUTF8StringEncoding];
    return [[tempStr stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+ (NSString *)getSign:(NSDictionary *)dataDic MD5Key:(NSString *)MD5Key {
    
    NSMutableString *tempStr = [NSMutableString string];
    NSArray *originKeys = [dataDic allKeys];
    
    // 1、ASCII排序
    NSArray *sortedKeys = [originKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 2、拼接字符串
    for (NSString *item in sortedKeys) {
        [tempStr appendFormat:@"%@=%@&", item, dataDic[item]];
    }
    
    // 3、截掉最后的"&"
    [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
    
    // 4、最后拼接MD5秘钥
    [tempStr appendString:MD5Key];
    
    // 5、MD5加密
    return [[self class] md5:tempStr];
}

+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getSHA256Sign:(NSDictionary *)dataDic MD5Key:(NSString *)MD5Key{
    NSMutableString *tempStr = [NSMutableString string];
    NSArray *originKeys = [dataDic allKeys];
    
    // 1、ASCII排序
    NSArray *sortedKeys = [originKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 2、拼接字符串
    for (NSString *item in sortedKeys) {
        [tempStr appendFormat:@"%@=%@&", item, dataDic[item]];
    }
    
    // 3、截掉最后的"&"
    [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
    // 4、最后拼接MD5秘钥
    [tempStr appendString:MD5Key];
    
    return [[self class] SHA256WithString:tempStr];
}

+ (NSString *)SHA256WithString:(NSString *)inputString {
    const char* str = [inputString UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    ret = (NSMutableString *)[ret uppercaseString];
    return ret;
}

+ (void)showHUD:(UIView *)targetView animated:(BOOL)animated {
    
    if (targetView) {
        [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
}

+ (void)hideHUD:(UIView *)targetView animated:(BOOL)animated {
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

+ (NSString *)getUUID {
    
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

@end
