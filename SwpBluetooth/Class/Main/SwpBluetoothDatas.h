//
//  SwpBluetoothDatas.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@class SwpBluetoothModel;

NS_ASSUME_NONNULL_BEGIN

#ifndef SwpBluetoothDatas_h
#define SwpBluetoothDatas_h


/**
 - SwpBluetoothPerpheralStage
 - SwpBluetoothPerpheralStageConnected:         连接
 - SwpBluetoothPerpheralStageServices:          服务
 - SwpBluetoothPerpheralStageCharacteristics:   特性，读写 等
 */
typedef NS_ENUM(NSInteger, SwpBluetoothPerpheralStage) {
    SwpBluetoothPerpheralStageConnected = 0,
    SwpBluetoothPerpheralStageServices,
    SwpBluetoothPerpheralStageCharacteristics,
};

/* SwpBluetooth 设备扫描，回调参数 */
typedef void(^SwpBluetoothPeripheralScanning)(NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *, id> *> *datas);

/* SwpBluetooth 设备连接成功，回调参数 */
typedef void(^SwpBluetoothConnectPeripheralSuccess)(CBPeripheral *perpheral, NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *, id> *> *datas);

/* SwpBluetooth 接设备无法连，连接失败，回调参数 */
typedef void(^SwpBluetoothConnectPeripheralFail)(CBPeripheral *perpheral, NSError *error);

/* SwpBluetooth 设备断开连接，回调参数 */
typedef void(^SwpBluetoothConnectPeripheralDisconnect)(CBPeripheral *perpheral, NSError *error);


#endif /* SwpBluetoothDatas_h */

NS_ASSUME_NONNULL_END
