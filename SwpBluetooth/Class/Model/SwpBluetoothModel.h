//
//  SwpBluetoothModel.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CBPeripheral;


NS_ASSUME_NONNULL_BEGIN

/**
 - SwpBluetoothStateConnect         连接状态
 - SwpBluetoothStateDisconnected:   没有连接
 - SwpBluetoothStateConnecting:     正在连接
 - SwpBluetoothStateConnected:      已经连接
 - SwpBluetoothStateDisconnecting:  正在断开连接
 */
typedef NS_ENUM(NSInteger, SwpBluetoothStateConnect) {
    SwpBluetoothStateDisconnected = 0,
    SwpBluetoothStateConnecting,
    SwpBluetoothStateConnected,
    SwpBluetoothStateDisconnecting,
};

@interface SwpBluetoothModel : NSObject

/* 元数据 */
@property (nonatomic, copy, readonly) NSDictionary      *metaDatas;
/* 蓝牙信号 */
@property (nonatomic, copy, readonly) NSNumber          *RSSI;
/* 广播数据 */
@property (nonatomic, copy, readonly) NSDictionary      *advertisement;
/* 蓝牙标识 */
@property (nonatomic, copy, readonly) NSUUID            *identifier;
/* 蓝牙名称 */
@property (nonatomic, copy, readonly) NSString          *name;
/* peripheral */
@property (nonatomic, copy, readonly) CBPeripheral      *peripheral;
/* 服务 UUIDs */
@property (nonatomic, copy, readonly) NSArray<NSUUID *>   *serviceUUIDs;
/* 服务 UUIDs */
@property (nonatomic, copy, readonly) NSArray<NSString *> *stringServiceUUIDs;


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothModel
 */
+ (instancetype)swpBluetoothWithDictionary:(NSDictionary *)dictionary;


/**
 *  @author swp_song
 *
 *  @brief  initWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothModel
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothWithDictionarys:    ( 数据转换 )
 *
 *  @param  dictionarys dictionarys
 *
 *  @return SwpBluetoothModel
 */
+ (NSArray<SwpBluetoothModel *> *)swpBluetoothWithDictionarys:(NSArray<NSDictionary<NSString *, id> *> *)dictionarys;


@end
NS_ASSUME_NONNULL_END
