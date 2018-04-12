//
//  SwpBluetoothListModel.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;

NS_ASSUME_NONNULL_BEGIN

/**
 - SwpBluetoothListStateConnect         连接状态
 - SwpBluetoothListStateDisconnected:   没有连接
 - SwpBluetoothListStateConnecting:     正在连接
 - SwpBluetoothListtateConnected:       已经连接
 - SwpBluetoothListStateDisconnecting:  正在断开连接
 */
typedef NS_ENUM(NSInteger, SwpBluetoothListStateConnect) {
    SwpBluetoothListStateDisconnected = 0,
    SwpBluetoothListStateConnecting,
    SwpBluetoothListtateConnected,
    SwpBluetoothListStateDisconnecting,
};



@interface SwpBluetoothListModel : NSObject

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
/* CBPeripheral peripheral */
@property (nonatomic, copy) id peripheral;
/* 连接状态 */
@property (nonatomic, assign) SwpBluetoothListStateConnect state;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothListModel
 */
+ (instancetype)swpBluetoothListWithDictionary:(NSDictionary *)dictionary;



/**
 *  @author swp_song
 *
 *  @brief  initWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothListModel
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListWithDictionarys:    ( 数据转换 )
 *
 *  @param  dictionarys dictionarys
 *
 *  @return SwpBluetoothListModel
 */
+ (NSArray<SwpBluetoothListModel *> *)swpBluetoothListWithDictionarys:(NSArray<NSDictionary<NSString *, id> *> *)dictionarys;


@end
NS_ASSUME_NONNULL_END
