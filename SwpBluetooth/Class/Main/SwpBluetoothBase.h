//
//  SwpBluetoothBase.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SwpBluetoothDatas.h"

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothBase : NSObject

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothManager ( 单利方法, 快速初始化 )
 *
 *  @return SwpBluetoothBase
 */
+ (instancetype)swpBluetoothManager;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothInfo    ( SwpBluetooth 信息 )
 *
 *  @return NSDictionary
 */
- (NSDictionary *)swpBluetoothInfo;


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothVersion  ( SwpBluetooth 版本号 )
 *
 *  @return NSString
 */
- (NSString *)swpBluetoothVersion;


@end
NS_ASSUME_NONNULL_END
