//
//  SwpBluetooth.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothBase.h"


NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSInteger const kSwpBluetoothDefaultWriteDataParagraphLength;

@interface SwpBluetooth : SwpBluetoothBase


/* 当前连接设备 */
@property (nonatomic, strong, readonly)  CBPeripheral *perpheral;
/* 当前设备阶段 */
@property (nonatomic, assign, readonly) SwpBluetoothPerpheralStage perpheralStage;

/**
 *  @author swp_song
 *
 *  @brief  sharedInstanceInit  ( 单利 )
 */
+ (__kindof SwpBluetooth * _Nonnull (^)(void))sharedInstanceInit;


#pragma mark - SwpBluetooth 扫描设备
/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStartScan   ( SwpBluetooth 开始扫描 )
 */
- (void)swpBluetoothStartScan;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStartScanChain  ( SwpBluetooth 开始扫描 )
 */
- (SwpBluetooth * _Nonnull (^)(void))swpBluetoothStartScanChain;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStopScan    ( SwpBluetooth 停止扫描 )
 */
- (void)swpBluetoothStopScan;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStopScanChain   ( SwpBluetooth 停止扫描 )
 */
- (SwpBluetooth * _Nonnull (^)(void))swpBluetoothStopScanChain;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothScanning:   ( SwpBluetooth， 回调方法，扫描设备调用 )
 *
 *  @param  scanning scanning
 */
- (void)swpBluetoothScanning:(SwpBluetoothPeripheralScanning _Nullable)scanning;


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothScanningChain   ( SwpBluetooth， 回调方法，扫描设备调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothPeripheralScanning _Nullable))swpBluetoothScanningChain;


#pragma mark - SwpBluetooth 设备连接，断开
/**
 *  @author swp_song
 *s
 *  @brief  swpBluetoothConnectPeripheral:connectSuccess:   ( SwpBluetooth 连接外设，连接成功回调 )
 *
 *  @param  peripheral      peripheral
 *
 *  @param  connectSuccess  connectSuccess
 */
- (void)swpBluetoothConnectPeripheral:(CBPeripheral *)peripheral connectSuccess:(SwpBluetoothConnectPeripheralSuccess _Nullable)connectSuccess;

/**
 *  @author swp_song
 *
 *  @brief swpBluetoothConnectPeripheralChain   ( SwpBluetooth 连接外设，连接成功回调 )
 */
- (SwpBluetooth * _Nonnull (^)(CBPeripheral * _Nonnull, SwpBluetoothConnectPeripheralSuccess _Nullable))swpBluetoothConnectPeripheralChain;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothCancelPeripheralConnection: ( SwpBluetooth 取消设备连接 )
 *
 *  @param  peripheral  peripheral
 */
- (void)swpBluetoothCancelPeripheralConnection:(CBPeripheral *)peripheral;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothCancelPeripheralConnectionChain ( SwpBluetooth 取消设备连接 )
 */
- (SwpBluetooth * _Nonnull (^)(CBPeripheral * _Nonnull))swpBluetoothCancelPeripheralConnectionChain;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothConnectPeripheralFail:  ( SwpBluetooth 回调方法，接设备无法连，连接失败，调用 )
 *
 *  @param  connectFail connectFail
 */
- (void)swpBluetoothConnectPeripheralFail:(SwpBluetoothConnectPeripheralFail _Nullable)connectFail;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothConnectPeripheralFailChain  ( SwpBluetooth 回调方法，接设备无法连，连接失败，调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothConnectPeripheralFail _Nullable))swpBluetoothConnectPeripheralFailChain;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralDisconnect:  ( SwpBluetooth 回调方法，设备断开连接，调用 )
 *
 *  @param  disconnect  disconnect
 */
- (void)swpBluetoothPeripheralDisconnect:(SwpBluetoothConnectPeripheralDisconnect _Nullable)disconnect;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralDisconnectChain   ( SwpBluetooth 回调方法，设备断开连接，调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothConnectPeripheralDisconnect _Nullable))swpBluetoothPeripheralDisconnectChain;


#pragma mark - SwpBluetooth 写入数据
- (void)sendPrintData:(NSData *)data;



@end
NS_ASSUME_NONNULL_END
