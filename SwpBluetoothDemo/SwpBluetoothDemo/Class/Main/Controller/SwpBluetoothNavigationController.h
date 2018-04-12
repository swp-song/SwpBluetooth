//
//  SwpBluetoothNavigationController.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothNavigationController : UINavigationController

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothNavigationControllerWithRootViewController: ( 快速初始化 )
 *
 *  @param  rootViewController      rootViewController
 *
 *  @return SwpBluetoothNavigationController
 */
+ (instancetype)swpBluetoothNavigationControllerWithRootViewController:(UIViewController *)rootViewController;

@end
NS_ASSUME_NONNULL_END
