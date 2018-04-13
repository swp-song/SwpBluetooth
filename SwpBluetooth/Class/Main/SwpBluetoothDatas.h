//
//  SwpBluetoothDatas.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@class SwpBluetooth, SwpBluetoothModel;

NS_ASSUME_NONNULL_BEGIN

#ifndef SwpBluetoothDatas_h
#define SwpBluetoothDatas_h

/**
 - SwpBluetoothPerpheralStage                   设备状态
 - SwpBluetoothPerpheralStageConnected:         连接
 - SwpBluetoothPerpheralStageServices:          服务
 - SwpBluetoothPerpheralStageCharacteristics:   特性，读写 等
 */

typedef NS_ENUM(NSInteger, SwpBluetoothPerpheralStage) {
    ///  连接
    SwpBluetoothPerpheralStageConnected = 0,
    ///  服务
    SwpBluetoothPerpheralStageServices,
    ///  特性，读写 等
    SwpBluetoothPerpheralStageCharacteristics,
};


/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothPeripheralBeginScanning    ( SwpBluetooth 设备扫描，回调参数 )
 *
 *  @param  swpBluetooth    swpBluetooth
 *
 *  @param  models          models
 *
 *  @param  metaDatas       metaDatas
 */
typedef void(^SwpBluetoothPeripheralBeginScanning)(SwpBluetooth *swpBluetooth, NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *, id> *> *metaDatas);

/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothPeripheralBeginScanning ( SwpBluetooth 设备连接成功，回调参数 )
 *
 *  @param  swpBluetooth    swpBluetooth
 *
 *  @param  perpheral       perpheral
 *
 *  @param  models          models
 *
 *  @param  metaDatas       metaDatas
 */
typedef void(^SwpBluetoothConnectPeripheralSuccess)(SwpBluetooth *swpBluetooth, CBPeripheral *perpheral, NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *, id> *> *metaDatas);

/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothConnectPeripheralFail ( SwpBluetooth 接设备无法连，连接失败，回调参数 )
 *
 *  @param  swpBluetooth    swpBluetooth
 *
 *  @param  perpheral       perpheral
 *
 *  @param  error           error
 */
typedef void(^SwpBluetoothConnectPeripheralFail)(SwpBluetooth *swpBluetooth, CBPeripheral *perpheral, NSError *error);



/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothConnectPeripheralDisconnect ( SwpBluetooth 设备断开连接，回调参数 )
 *
 *  @param  swpBluetooth    swpBluetooth
 *
 *  @param  perpheral       perpheral
 *
 *  @param  models          models
 *
 *  @param  metaDatas       metaDatas
 *
 *  @param  error           error
 */
typedef void(^SwpBluetoothConnectPeripheralDisconnect)(SwpBluetooth *swpBluetooth, CBPeripheral *perpheral, NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *, id> *> *metaDatas, NSError *error);


/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothConnectPeripheralDisconnect ( SwpBluetooth 设备写入数据，回调参数 )
 *
 *  @param  swpBluetooth    swpBluetooth
 *
 *  @param  completion      completion
 *
 *  @param  perpheral       perpheral
 *
 *  @param  error           error
 *
 *  @param  errorMessage    errorMessage
 */
typedef void(^SwpBluetoothWriteDataCompletion)(SwpBluetooth *swpBluetooth, BOOL completion, CBPeripheral *perpheral, NSError * _Nullable error, NSString * _Nullable errorMessage);


#endif /* SwpBluetoothDatas_h */

NS_ASSUME_NONNULL_END
