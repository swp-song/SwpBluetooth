//
//  SwpBluetoothUtils.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBCentralManager, CBPeripheral;

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothUtils : NSObject

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsScanDataFiltering:central:peripheral:advertisement:RSSI:   ( 设备数据过滤 )
 *
 *  @param  datas           datas
 *
 *  @param  central         central
 *
 *  @param  peripheral      peripheral
 *
 *  @param  advertisement   advertisement
 *
 *  @param  RSSI            RSSI
 *
 *  @return NSArray
 */
+ (NSArray<NSDictionary *> *)swpBluetoothUtilsScanDataFiltering:(NSArray *)datas central:(CBCentralManager *)central peripheral:(CBPeripheral *)peripheral advertisement:(NSDictionary<NSString *, id> *)advertisement RSSI:(NSNumber *)RSSI;



/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsUpdateDatas:   ( 设备数据过滤 )
 *
 *  @param  datas   datas
 *
 *  @return NSArray
 */
+ (NSArray<NSDictionary *> *)swpBluetoothUtilsUpdateDatas:(NSArray<NSDictionary<NSString *, id> *> *)datas;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsSetUserDefaults:   ( NSUserDefaults 存 )
 *
 *  @param  value   value
 *
 *  @param  key     key
 *
 *  @return BOOL
 */
+ (BOOL)swpBluetoothUtilsSetUserDefaults:(id)value forKey:(NSString *)key;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsGetUserDefaults:   ( NSUserDefaults 取 )
 *
 *  @param  key key
 *
 *  @return id
 */
+ (id)swpBluetoothUtilsGetUserDefaults:(NSString *)key;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsRemoveUserDefaults:    ( NSUserDefaults 移除 )
 *
 *  @param  key key
 *
 *  @return BOOL
 */
+ (BOOL)swpBluetoothUtilsRemoveUserDefaults:(NSString *)key;


@end
NS_ASSUME_NONNULL_END
