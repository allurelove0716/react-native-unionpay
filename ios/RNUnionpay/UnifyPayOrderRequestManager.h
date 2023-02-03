//
//  UnifyPayOrderRequestManager.h
//  testDEMO
//
//  Created by SunXP on 17/4/28.
//  Copyright © 2017年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL_ORDER_TEST_POS_1        @"https://qr-test1.chinaums.com/netpay-route-server/api/"
#define URL_ORDER_TEST_POS_2        @"https://qr-test2.chinaums.com/netpay-route-server/api/"
#define URL_ORDER_TEST_POS_3        @"https://qr-test3.chinaums.com/netpay-route-server/api/"
#define URL_ORDER_TEST_WX_ALI_1     @"http://npfdev.izhong.me/netpay-route-server/api/"
#define URL_ORDER_TEST_WX_ALI_2     @"http://umspay.izhong.me/netpay-route-server/api/"
#define URL_ORDER_PROD              @"https://qr.chinaums.com/netpay-route-server/api/"

#define WX_POS_TEST_MD5KEY @"EahB2xfpCCpaYtKw2yCWzcTfChTxXEYKCGwBEaMcDKbEHCpE"
#define POS_PRO_MD5KEY @"3ypmTzxdXhFty7HCrZynehjcjdcaAb3HDRwJQpTFYZfjWHEZ"
#define WX_ALI_TEST_MD5KEY @"1234567890lkkjjhhguuijmjfidfi4urjrjmu4i84jvm"
#define ALI_TEST_2_MD5KEY @"dwpRz2B6akcp8fwp6JJjenHCH7FKHFcCPE3NkiMJAQzhtD3W"
#define WX_ALI_PRO_MD5KEY @"kkikm48475jrnfjmdnh3yyt35eyjdnnbxheujjejemmjyu3u4i4jj4d9ikfjjdf"
//#define WX_PRO_MD5KEY @"fZjyfDK7ix7CKhhBSC8mQWTAtmp44JsTrbkkyKXtxNAxxPFT"
#define WX_PRO_MD5KEY @"BcNys5ix3zj4TTSz8HhrXWrZJZHWJBXzMSXdNWxPZ6B7JasS"

#define WX_TEST_MD5KEY @"fcAmtnx7MwismjWNhNKdHC44mNXtnEQeJkRrhKJwyrW2ysRR"
#define CLOUD_PRO_MD5KEY @"AcZdi46z6GibDwi5WXQEdypEWt2WSdNH6RHT3YAwnmCWwQEG"
#define ALI_PRO_MD5KEY @"AcZdi46z6GibDwi5WXQEdypEWt2WSdNH6RHT3YAwnmCWwQEG"

extern NSString *const Test_1_Title;
extern NSString *const Test_2_Title;
extern NSString *const Test_3_Title;
extern NSString *const Prod_Title;
extern NSString *const True_Title;
extern NSString *const False_Title;

extern NSString *const MsgSrcId_1016;
extern NSString *const MsgSrcId_3028;
extern NSString *const MsgSrcId_3816;
extern NSString *const MsgSrcId_3194;
extern NSString *const MsgSrcId_3245;
extern NSString *const MsgSrcId_1028;
extern NSString *const MsgSrcId_1000;
extern NSString *const MsgSrcId_5000;

extern NSString *const MsgSrc_TestPay;
extern NSString *const MsgSrc_NetPay_Demo;

typedef NS_ENUM(NSInteger, UnifyPayChannel) {
    unifyPayChannelWXPay = 0,
    unifyPayChannelPosPay,
    unifyPayChannelAlipay,
    unifyPayChannelAliMiniProgramPay,
    unifyPayChannelCloudPay,
    unifyPayChannelApplePay,
};

typedef void (^SuccessHandler)(NSDictionary *response);
typedef void (^FailHandler)();

@interface UnifyPayOrderRequestManager : NSObject

@property (nonatomic, assign) UnifyPayChannel payChannel;    // 支付渠道
@property (nonatomic, copy) NSString *subAppId;


@property (nonatomic, copy) NSString *requestTimestamp;   // 当前时间

@property (nonatomic, copy) NSString *merOrderId;            // 商户订单号

@property (nonatomic, copy) NSString *mid;                      // 商户号

@property (nonatomic, copy) NSString *tid;                       // 终端号

@property (nonatomic, copy) NSString *instMid;                 // 机构商户号

@property (nonatomic, copy) NSString *goods;                   // 商品详情

@property (nonatomic, copy) NSString *totalAmount;           // 总金额，单位分

@property (nonatomic, copy) NSString *merchantUserId;      // 商户用户号

@property (nonatomic, copy) NSString *mobile;                   // 手机号

@property (nonatomic, copy) NSString *msgSrc;                 // 消息来源

@property (nonatomic, copy) NSString *urlStr;                   // 下单接口URL

@property (nonatomic, copy) NSString *MD5Key;                // MD5Key

@property (nonatomic, copy) NSString *notifyUrl;               // 通知地址

@property (nonatomic, copy) NSString *srcReserve;               //商户定制化展示的内容，长度不大于255

@property (nonatomic, copy) NSString *secureTransaction;        //担保标示

#pragma  mark --apple pay 字段

@property (nonatomic, copy) NSString *attachedData;           //商户附加数据

@property (nonatomic, copy) NSString *expireTime;             //订单过期时间

@property (nonatomic, copy) NSString *orderDesc;              //订单描述

@property (nonatomic, copy) NSString *originalAmount;         //订单原始金额，单位分，用于记录前端系统打折前的金额

@property (nonatomic, copy) NSString *customerId;            //全民付用户号

@property (nonatomic, copy) NSString *signType;                //签名算法

//以后需求可能用的上
//@property (nonatomic, copy) NSString *specifiedPaymentMedium;  //支付介质

@property (nonatomic, copy) NSString *divisionFlag;            //分账标记

@property (nonatomic, copy) NSString *platformAmount;            //平台商户分账 金额

@property (nonatomic, copy) NSArray *subOrdersArray;              

@property (nonatomic, copy) NSString *subOrdersStr;

//MARK:--- 云闪付下单新增字段 ---
@property (nonatomic, copy) NSString *bankCardNo; // bankCardNo
@property (nonatomic, copy) NSString *supportBank; // supportBank
@property (nonatomic, copy) NSString *invokeType; // invokeType

@property (nonatomic, copy) NSString *name; // name
@property (nonatomic, copy) NSString *certType; // certType
@property (nonatomic, copy) NSString *certNo; // certNo
@property (nonatomic, copy) NSString *fixBuyer; // fixBuyer

+(UnifyPayOrderRequestManager *)shareInstance;

- (NSData *)packToData;

- (void)sendOrderRequestWithPostData:(NSData *)postData successHandler:(SuccessHandler)successHandler failHandler:(FailHandler)failHandler;


@end
