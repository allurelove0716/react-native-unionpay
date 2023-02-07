
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

#import <UIKit/UIKit.h>
#import <UIKit/UIViewController.h>

//NS_ASSUME_NONNULL_BEGIN
//
//@interface RNUnionpay : UIViewController
//@end

@interface RNUnionpay : RCTEventEmitter <RCTBridgeModule>



@property NSString* schemeStr;

//弹出提示框
- (void)showAlertWithTitle:(NSString *)title;

@end
