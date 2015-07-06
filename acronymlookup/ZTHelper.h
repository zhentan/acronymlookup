//
//  ZTHelper.h
//  acronymlookup
//
//  Created by zhen tan on 7/5/15.
//  Copyright (c) 2015 zhen tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AcromineClient.h"
#import "MBProgressHUD.h"

@interface ZTHelper : NSObject

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showOKAlertWithError:(NSError *)error;

@end
