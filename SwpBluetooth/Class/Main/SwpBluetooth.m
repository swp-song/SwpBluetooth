//
//  SwpBluetooth.m
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetooth.h"

#import "SwpBluetoothUtils.h"
#import "SwpBluetoothModel.h"



NSInteger const kSwpBluetoothDefaultWriteDataDefaultLength = 146;

@interface SwpBluetooth () <CBCentralManagerDelegate, CBPeripheralDelegate>

/* 中心管理器 */
@property (nonatomic, strong) CBCentralManager                      *centralManager;
/* 搜索到设备元数据  */
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *metaDatas;
/* 发现设备可写服务  */
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *writeChatacters;
/* 搜索到设备模型数据 */
@property (nonatomic, copy) NSArray<SwpBluetoothModel *>            *modelDatas;

/* SwpBluetooth 回调方法，设备扫描调用 */
@property (nonatomic, copy) SwpBluetoothPeripheralScanning          peripheralScanning;
/* SwpBluetooth 回调方法，设备连接成功调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralSuccess    peripheralConnectSuccess;
/* SwpBluetooth 回调方法，接设备无法连，连接失败，调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralFail       peripheralConnectFail;
/* SwpBluetooth 回调方法，设备断开连接，调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralDisconnect peripheralDisconnect;


@end

@implementation SwpBluetooth


/**
 *  @author swp_song
 *
 *  @brief  init    ( Override init )
 *
 *  @return SwpBluetooth
 */
- (instancetype)init {
    
    if (self = [super init]) {
        [self _dataInit];
    }
    
    return self;
}

#pragma mark - CBCentral Manager Delegate Methods
/**
 *  @author swp_song
 *
 *  @brief  centralManagerDidUpdateState    ( CBCentral 代理方法，蓝牙发生变化时调用 )
 *
 *  @param  central central
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
            
        case CBManagerStateUnknown:
            NSLog(@">>>CBManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@">>>CBManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@">>>CBManagerStatePoweredOff");
            break;
        case CBManagerStatePoweredOn:
            NSLog(@">>>CBManagerStatePoweredOn");
            // 2.开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            //  设备开启，开始扫描设备
            NSLog(@"开启扫描");
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        default:
            break;
    }
}


/**
 *  @author swp_song
 *
 *  @brief  centralManager:didDiscoverPeripheral:advertisementData:RSSI:    ( CBCentral 代理方法，扫描外设 <蓝牙> )
 *
 *  @param  central             central
 *
 *  @param  peripheral          peripheral
 *
 *  @param  advertisementData   advertisementData
 *
 *  @param  RSSI                RSSI
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (!peripheral.name.length) return;
    
    NSLog(@"扫描中..");
    _metaDatas  = [SwpBluetoothUtils swpBluetoothUtilsScanDataFiltering:_metaDatas central:central peripheral:peripheral advertisement:advertisementData RSSI:RSSI];
    _modelDatas = [SwpBluetoothModel swpBluetoothWithDictionarys:_metaDatas];
    if (self.peripheralScanning) self.peripheralScanning(_modelDatas, _metaDatas);
    
}

#pragma mark - CBPeripheral Delegate Methods


/**
 *  @author swp_song
 *
 *  @brief  centralManager:didConnectPeripheral:    ( CBPeripheral 代理方法，外设连接成功调用 )
 *
 *  @param  central     central
 *
 *  @param  peripheral  peripheral
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
 
    [_centralManager stopScan];
    
    _perpheral      = peripheral;
    _perpheralStage = SwpBluetoothPerpheralStageConnected;
    
    //  设置代理
    peripheral.delegate = self;
    
    //  发现服务
    [peripheral discoverServices:nil];
    
    //
    _metaDatas  = [SwpBluetoothUtils swpBluetoothUtilsUpdateDatas:_metaDatas];
    _modelDatas = [SwpBluetoothModel swpBluetoothWithDictionarys:_metaDatas];
    
    if (self.peripheralConnectSuccess) self.peripheralConnectSuccess(peripheral, _modelDatas, _metaDatas);
}


/**
 *  @author swp_song
 *
 *  @brief  centralManager:didFailToConnectPeripheral:erro: ( CBPeripheral 代理方法，外设连接失败调用 )
 *
 *  @param  central     central
 *
 *  @param  peripheral  peripheral
 *
 *  @param  error       error
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    _perpheralStage = SwpBluetoothPerpheralStageConnected;
    NSLog(@"%@ 无法连接该设备", peripheral.name);
    if (self.peripheralConnectFail) self.peripheralConnectFail(peripheral, error);
}

/**
 *  @author swp_song
 *
 *  @brief  centralManager:didDisconnectPeripheral:error:   ( CBPeripheral 代理方法，外设断开连接调用 )
 *
 *  @param  central     central
 *
 *  @param  peripheral  peripheral
 *
 *  @param  error       error
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    _perpheralStage = SwpBluetoothPerpheralStageConnected;
    NSLog(@"%@ 设备已断开连接", peripheral.name);
    if (self.peripheralDisconnect) self.peripheralDisconnect(peripheral, error);
    
}

/**
 *  @author swp_song
 *
 *  @brief  peripheral:didDiscoverServices:   ( CBPeripheral 代理方法，发现外设服务调用 )
 *
 *  @param  peripheral  peripheral
 *
 *  @param  error       error
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    
    
    if (error) {
        
        NSLog(@"发现服务出错 错误原因-%@", error.domain);
    } else {
        
        [peripheral.services enumerateObjectsUsingBlock:^(CBService * _Nonnull service, NSUInteger idx, BOOL * _Nonnull stop) {
            //  扫描新特性
            [peripheral discoverCharacteristics:nil forService:service];
        }];
        
    }
    _perpheralStage = SwpBluetoothPerpheralStageServices;
}


/**
 *  @author swp_song
 *
 *  @brief  peripheral:didDiscoverCharacteristicsForService:error:  ( CBPeripheral 代理方法，发现服务特性调用 )
 *
 *  @param  peripheral  peripheral
 *
 *  @param  service     service
 *
 *  @param  error       error
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    
    NSMutableArray *temp = NSMutableArray.new;
    
    if (error) {
        
        NSLog(@"发现特性出错 错误原因-%@", error.domain);
        
    } else {

        
        [service.characteristics enumerateObjectsUsingBlock:^(CBCharacteristic * _Nonnull character, NSUInteger idx, BOOL * _Nonnull stop) {
           
            //  这是一个枚举类型的属性
            CBCharacteristicProperties properties = character.properties;
            
            if (properties & CBCharacteristicPropertyBroadcast) {
                //  如果是广播特性
            }
            
            if (properties & CBCharacteristicPropertyRead) {
                //  如果具备读特性，即可以读取特性的value
                [peripheral readValueForCharacteristic:character];
            }
            
            if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
                //  如果具备写入值不需要响应的特性
                //  这里保存这个可以写的特性，便于后面往这个特性中写数据
                NSDictionary *datas = @{@"character" : character, @"type" : @(CBCharacteristicWriteWithResponse)};
                [temp addObject:datas];
            }
            
            if (properties & CBCharacteristicPropertyWrite) {
                //如果具备写入值的特性，这个应该会有一些响应
            }
            
            if (properties & CBCharacteristicPropertyNotify) {
            
                //如果具备通知的特性，无响应
                [peripheral setNotifyValue:YES forCharacteristic:character];
            }
            
        }];
        

    }
    
    if (temp.count > 0) {
        _perpheralStage  = SwpBluetoothPerpheralStageCharacteristics;
        _writeChatacters = temp.copy;
    }
}

/**
 *  @author swp_song
 *
 *  @brief  peripheral:didWriteValueForCharacteristic:dataLength:error: ( CBPeripheral 代理方法，写入数据完毕调用 )
 *
 *  @param  peripheral      peripheral
 *
 *  @param  characteristic  characteristic
 *
 *  @param  error           error
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
 
    if (error) {
        //        _printResult(NO,_connectedPerpheral,@"发送失败");
    } else {
        //        _printResult(YES,_connectedPerpheral,@"已成功发送至蓝牙设备");
        NSLog(@"123");
    }
}

#pragma mark - Private Methods
/**
 *  @author swp_song
 *
 *  @brief  _dataInit   ( 数据初始化 )
 */
- (void)_dataInit {
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    _metaDatas       = NSArray.new;
    _modelDatas      = NSArray.new;
    _writeChatacters = NSArray.new;
    _perpheral       = nil;
}

/**
 *  @author swp_song
 *
 *  @brief  _writeValue:peripheral:dataLength:characteristic:type:  ( 写入数据方法 )
 *
 *  @param  data            data
 *
 *  @param  peripheral      peripheral
 *
 *  @param  length          length
 *
 *  @param  characteristic  characteristic
 *
 *  @param  type            type
 */
- (void)_writeValue:(NSData *)data peripheral:(CBPeripheral *)peripheral dataLength:(NSInteger)length characteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type {
    
    
    
    if (length <= 0) {
        [peripheral writeValue:data forCharacteristic:characteristic type:type];
        return;
    }
    
    if (data.length <= length) {
        
        [peripheral writeValue:data forCharacteristic:characteristic type:type];
        
    } else {
        
        NSInteger index = 0;
        
        for (index = 0; index < data.length - length; index += length) {
            NSData *tempData = [data subdataWithRange:NSMakeRange(index, length)];
            [peripheral writeValue:tempData forCharacteristic:characteristic type:type];
        }
        
        NSData *tempData = [data subdataWithRange:NSMakeRange(index, data.length - index)];
        [peripheral writeValue:tempData forCharacteristic:characteristic type:type];
        
    }
    
}




#pragma mark - Public Methods
#pragma mark - SwpBluetooth 扫描设备

/**
 *  @author swp_song
 *
 *  @brief  sharedInstanceInit  ( 单利 )
 */
+ (__kindof SwpBluetooth * _Nonnull (^)(void))sharedInstanceInit {
    return ^() {
        return [self.class sharedInstance];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStartScan   ( SwpBluetooth 开始扫描 )
 */
- (void)swpBluetoothStartScan {
    
    NSLog(@"开启扫描");
    if (!_centralManager) {
        [self _dataInit];
    }
    
    if (@available(iOS 10.0, *)) {
        if (_centralManager.state == CBManagerStatePoweredOn) {
            //开启搜索
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
            return;
        }
        
    } else {
        
        if (_centralManager.state == CBCentralManagerStatePoweredOn) {
            //开启搜索
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
            return;
        }
    }
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStartScanChain  ( SwpBluetooth 开始扫描 )
 */
- (SwpBluetooth * _Nonnull (^)(void))swpBluetoothStartScanChain {
    return ^() {
        [self swpBluetoothStartScan];
        return self;
    };
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStopScan    ( SwpBluetooth 停止扫描 )
 */
- (void)swpBluetoothStopScan {
    [_centralManager stopScan];
    NSLog(@"停止扫描");
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStopScanChain   ( SwpBluetooth 停止扫描 )
 */
- (SwpBluetooth * _Nonnull (^)(void))swpBluetoothStopScanChain {
    return ^() {
        [self swpBluetoothStopScan];
        return self;
    };
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothScanning:   ( SwpBluetooth， 回调方法，扫描设备调用 )
 *
 *  @param  scanning scanning
 */
- (void)swpBluetoothScanning:(SwpBluetoothPeripheralScanning)scanning {
    _peripheralScanning = scanning;
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothScanningChain   ( SwpBluetooth， 回调方法，扫描设备调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothPeripheralScanning))swpBluetoothScanningChain {
    
    return ^(SwpBluetoothPeripheralScanning scanning) {
        [self swpBluetoothScanning:scanning];
        return self;
    };
}


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
- (void)swpBluetoothConnectPeripheral:(CBPeripheral *)peripheral connectSuccess:(SwpBluetoothConnectPeripheralSuccess)connectSuccess {
 
    //  关闭之前的连接
    if (_perpheral) {
        [self swpBluetoothCancelPeripheralConnection:_perpheral];
    }
    
    //  重新连接
    [_centralManager connectPeripheral:peripheral options:nil];
    _peripheralConnectSuccess = connectSuccess;
}


/**
 *  @author swp_song
 *
 *  @brief swpBluetoothConnectPeripheralChain   ( SwpBluetooth 连接外设，连接成功回调 )
 */
- (SwpBluetooth * _Nonnull (^)(CBPeripheral * _Nonnull, SwpBluetoothConnectPeripheralSuccess))swpBluetoothConnectPeripheralChain {
    
    return ^(CBPeripheral *peripheral, SwpBluetoothConnectPeripheralSuccess connectSuccess) {
        [self swpBluetoothConnectPeripheral:peripheral connectSuccess:connectSuccess];
        return self;
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothCancelPeripheralConnection: ( SwpBluetooth 取消设备连接 )
 *
 *  @param  peripheral  peripheral
 */
- (void)swpBluetoothCancelPeripheralConnection:(CBPeripheral *)peripheral {
    
    if (!peripheral) return;
    [_centralManager cancelPeripheralConnection:peripheral];
    _writeChatacters = NSArray.new;
    _perpheral       = nil;
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothCancelPeripheralConnectionChain ( SwpBluetooth 取消设备连接 )
 */
- (SwpBluetooth * _Nonnull (^)(CBPeripheral * _Nonnull))swpBluetoothCancelPeripheralConnectionChain {
    
    return ^(CBPeripheral *peripheral) {
        [self swpBluetoothCancelPeripheralConnection:peripheral];
        return self;
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothConnectPeripheralFail:  ( SwpBluetooth 回调方法，接设备无法连，连接失败，调用 )
 *
 *  @param  connectFail connectFail
 */
- (void)swpBluetoothConnectPeripheralFail:(SwpBluetoothConnectPeripheralFail)connectFail {
    _peripheralConnectFail = connectFail;
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothConnectPeripheralFailChain  ( SwpBluetooth 回调方法，接设备无法连，连接失败，调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothConnectPeripheralFail))swpBluetoothConnectPeripheralFailChain {
    
    return ^(SwpBluetoothConnectPeripheralFail connectFail) {
        [self swpBluetoothConnectPeripheralFail:connectFail];
        return self;
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralDisconnect:  ( SwpBluetooth 回调方法，设备断开连接，调用 )
 *
 *  @param  disconnect  disconnect
 */
- (void)swpBluetoothPeripheralDisconnect:(SwpBluetoothConnectPeripheralDisconnect)disconnect {
    _peripheralDisconnect = disconnect;
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralDisconnectChain   ( SwpBluetooth 回调方法，设备断开连接，调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothConnectPeripheralDisconnect))swpBluetoothPeripheralDisconnectChain {
    return ^(SwpBluetoothConnectPeripheralFail disconnect) {
        [self swpBluetoothPeripheralDisconnect:disconnect];
        return self;
    };
}


- (void)sendPrintData:(NSData *)data {
    
    NSDictionary *cachedData         = _writeChatacters.lastObject;
    CBCharacteristic *characteristic = cachedData[@"character"];
    CBCharacteristicWriteType type   = [cachedData[@"type"] integerValue];
    [self _writeValue:data peripheral:_perpheral dataLength:kSwpBluetoothDefaultWriteDataDefaultLength characteristic:characteristic type:type];
}




@end
