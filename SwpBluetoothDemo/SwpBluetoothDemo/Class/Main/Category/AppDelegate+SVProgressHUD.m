
//
//  AppDelegate+SVProgressHUD.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/13.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "AppDelegate+SVProgressHUD.h"

#import <SVProgressHUD/SVProgressHUD.h>

@implementation AppDelegate (SVProgressHUD)

/**
 *  @author swp_song
 *
 *  @brief  setSVProgressHUD  ( 设置 SVProgressHUD 样式 )
 */
+ (AppDelegate * _Nonnull (^)(void))setSVProgressHUD {
    
    return ^() {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD setFadeOutAnimationDuration:1];
        return (AppDelegate *)UIApplication.sharedApplication.delegate;
    };
}

@end
