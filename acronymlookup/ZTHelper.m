//
//  ZTHelper.m
//  acronymlookup
//
//  Created by zhen tan on 7/5/15.
//  Copyright (c) 2015 zhen tan. All rights reserved.
//

#import "ZTHelper.h"

@implementation ZTHelper

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (void)showOKAlertWithError:(NSError *)error {
    [self showOKAlertWithTitle:@"Error" message:error.localizedDescription];
    NSLog(@"%@", error.localizedDescription);
}

@end
