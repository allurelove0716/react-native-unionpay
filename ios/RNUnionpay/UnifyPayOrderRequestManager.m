//
//  UnifyPayOrderRequestManager.m
//  testDEMO
//
//  Created by SunXP on 17/4/28.
//  Copyright © 2017年 L. All rights reserved.
//

#import "UnifyPayOrderRequestManager.h"
#import "UnifyPayTool.h"

#define TIME_OUT_ORDER 15.0

NSString *const Test_1_Title = @"测试环境_1";
NSString *const Test_2_Title = @"测试环境_2";
NSString *const Test_3_Title = @"测试环境_3";
NSString *const Prod_Title = @"生产环境";
NSString *const True_Title = @"true";
NSString *const False_Title = @"false";

NSString *const MsgSrcId_1016 = @"1016";
NSString *const MsgSrcId_3028 = @"3028";
NSString *const MsgSrcId_3816 = @"3816";
NSString *const MsgSrcId_3194 = @"3194";
NSString *const MsgSrcId_3245 = @"3245";
NSString *const MsgSrcId_1028 = @"1028";
NSString *const MsgSrcId_1000 = @"1000";
NSString *const MsgSrcId_5000 = @"5000";

NSString *const MsgSrc_TestPay = @"WWW.TEST.COM";
NSString *const MsgSrc_NetPay_Demo = @"WWW.PRODTEST.COM";

static UnifyPayOrderRequestManager *shareInstance;
@implementation UnifyPayOrderRequestManager

- (NSData *)packToData {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    switch (self.payChannel) {
        case unifyPayChannelWXPay:
        {
            EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.msgSrc, @"msgSrc");
            EncodeUnEmptyStrObjctToDic(dataDic, self.notifyUrl, @"notifyUrl");
            EncodeUnEmptyStrObjctToDic(dataDic, self.subAppId, @"subAppId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");

            if (self.subOrdersArray.count > 0) {
                EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
            }
            EncodeUnEmptyStrObjctToDic(dataDic, @"wx.appPreOrder", @"msgType");
            EncodeUnEmptyStrObjctToDic(dataDic, @"APP", @"tradeType");
            EncodeUnEmptyStrObjctToDic(dataDic, @"SHA256", @"signType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.srcReserve, @"srcReserve");
            EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSHA256Sign:dataDic MD5Key:self.MD5Key], @"sign");

        
        }
            break;
            
        case unifyPayChannelPosPay:
        {
            EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merchantUserId, @"merchantUserId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mobile, @"mobile");
            EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");

            if (self.subOrdersArray.count > 0) {
                EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
            }
            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getUUID], @"msgId");
            EncodeUnEmptyStrObjctToDic(dataDic, @"ERP_SCANPAY", @"msgSrc");
            EncodeUnEmptyStrObjctToDic(dataDic, @"qmf.order", @"msgType");
            EncodeUnEmptyStrObjctToDic(dataDic, @"NETPAY", @"orderSource");
            EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
            EncodeUnEmptyStrObjctToDic(dataDic, @"SHA256", @"signType");

            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSign:dataDic MD5Key:self.MD5Key], @"sign");
        }
            break;
            
        case unifyPayChannelAlipay:
        {
            EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.msgSrc, @"msgSrc");
            EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");

            if (self.subOrdersArray.count > 0) {
                EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
            }
            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getUUID], @"msgId");
            EncodeUnEmptyStrObjctToDic(dataDic, @"trade.precreate", @"msgType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.srcReserve, @"srcReserve");
            EncodeUnEmptyStrObjctToDic(dataDic, @"APP", @"tradeType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
            EncodeUnEmptyStrObjctToDic(dataDic, @"SHA256", @"signType");

            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSHA256Sign:dataDic MD5Key:self.MD5Key], @"sign");
        }
            break;
            case unifyPayChannelAliMiniProgramPay:
            {
                EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
                EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
                EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
                EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
                EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
                EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.msgSrc, @"msgSrc");
                EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");

                if (self.subOrdersArray.count > 0) {
                    EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                    EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                    EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
                }
                EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getUUID], @"msgId");
                EncodeUnEmptyStrObjctToDic(dataDic, @"trade.appPreOrder", @"msgType");
                EncodeUnEmptyStrObjctToDic(dataDic, self.srcReserve, @"srcReserve");
                EncodeUnEmptyStrObjctToDic(dataDic, @"APP", @"tradeType");
                EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
                EncodeUnEmptyStrObjctToDic(dataDic, @"SHA256", @"signType");

                EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSHA256Sign:dataDic MD5Key:self.MD5Key], @"sign");
            }
                break;
            
        case unifyPayChannelCloudPay:
        {
            EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.msgSrc, @"msgSrc");
            EncodeUnEmptyStrObjctToDic(dataDic, self.notifyUrl, @"notifyUrl");
            EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");

            //云闪付新增字段
            EncodeUnEmptyStrObjctToDic(dataDic, self.bankCardNo, @"bankCardNo");
            EncodeUnEmptyStrObjctToDic(dataDic, self.supportBank, @"supportBank");
            EncodeUnEmptyStrObjctToDic(dataDic, self.invokeType, @"invokeType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.name, @"name");
            EncodeUnEmptyStrObjctToDic(dataDic, self.certType, @"certType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.certNo, @"certNo");
            EncodeUnEmptyStrObjctToDic(dataDic, self.fixBuyer, @"fixBuyer");
            
            if (self.subOrdersArray.count > 0) {
                EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
            }
            EncodeUnEmptyStrObjctToDic(dataDic, @"uac.appOrder", @"msgType");
            EncodeUnEmptyStrObjctToDic(dataDic, @"APP", @"tradeType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.srcReserve, @"srcReserve");
            EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
            EncodeUnEmptyStrObjctToDic(dataDic, @"SHA256", @"signType");

            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSHA256Sign:dataDic MD5Key:self.MD5Key], @"sign");
        }
            break;
        case unifyPayChannelApplePay:
        {
            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getUUID], @"msgId");
            EncodeUnEmptyStrObjctToDic(dataDic, @"QMFGROUP", @"msgSrc");
            EncodeUnEmptyStrObjctToDic(dataDic, @"applepay.order", @"msgType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.requestTimestamp, @"requestTimestamp");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merOrderId, @"merOrderId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.srcReserve, @"srcReserve");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mid, @"mid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.tid, @"tid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.instMid, @"instMid");
            EncodeUnEmptyStrObjctToDic(dataDic, self.attachedData, @"attachedData");
            EncodeUnEmptyStrObjctToDic(dataDic, self.expireTime, @"expireTime");
            EncodeUnEmptyStrObjctToDic(dataDic, self.orderDesc, @"orderDesc");
            if (self.subOrdersArray.count > 0) {
                EncodeUnEmptyStrObjctToDic(dataDic, self.divisionFlag, @"divisionFlag");
                EncodeUnEmptyStrObjctToDic(dataDic, self.platformAmount, @"platformAmount");
                EncodeUnEmptyStrObjctToDic(dataDic, self.subOrdersStr, @"subOrders");
            }
            EncodeUnEmptyStrObjctToDic(dataDic, self.originalAmount, @"originalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.totalAmount, @"totalAmount");
            EncodeUnEmptyStrObjctToDic(dataDic, self.customerId, @"customerId");
            EncodeUnEmptyStrObjctToDic(dataDic, self.notifyUrl, @"notifyUrl");
            EncodeUnEmptyStrObjctToDic(dataDic, self.signType, @"signType");
            EncodeUnEmptyStrObjctToDic(dataDic, self.mobile, @"mobile");
            EncodeUnEmptyStrObjctToDic(dataDic, self.secureTransaction, @"secureTransaction");
            EncodeUnEmptyStrObjctToDic(dataDic, self.merchantUserId, @"merchantUserId");
            EncodeUnEmptyStrObjctToDic(dataDic, [UnifyPayTool getSign:dataDic MD5Key:self.MD5Key], @"sign");
        }
            break;
            
        default:
            return nil;
            break;
    }
    if (self.subOrdersArray.count > 0) {
        [dataDic setObject:self.subOrdersArray forKey:@"subOrders"];
    }
    NSLog(@"\nrequest = %@", dataDic);
    return [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
}

- (void)sendOrderRequestWithPostData:(NSData *)postData successHandler:(SuccessHandler)successHandler failHandler:(FailHandler)failHandler {
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    request.timeoutInterval = TIME_OUT_ORDER;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ((responseDic != nil) && ([responseDic count] != 0)) {
                    successHandler(responseDic);
                } else {
                    failHandler();
                }
            } else {
                failHandler();
            }
        });
    }];
    [sessionDataTask resume];
}

void EncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key)
{
    if (dic == nil || [dic isEqual:[NSNull null]])
    {
        return;
    }
    
    if (object == nil || [object isEqual:[NSNull null]] || [object isEqualToString:@""])
    {
        return;
    }
    
    if (key == nil || [key isEqual:[NSNull null]] || [key isEqualToString:@""])
    {
        return;
    }
    
    [dic setObject:object forKey:key];
}

+ (UnifyPayOrderRequestManager *)shareInstance {
    @synchronized(self)
    {
        if (shareInstance==Nil) {
            shareInstance=[[self alloc]init];
        }
        return shareInstance;
    }
}

@end
