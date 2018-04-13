//
//  SwpBluetooth.m
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetooth.h"

/* ---------------------- Tool       ---------------------- */
#import "SwpBluetoothUtils.h"
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
#import "SwpBluetoothModel.h"
/* ---------------------- Model      ---------------------- */


/** 分段打印默认 Data 长度 */
NSInteger  const kSwpBluetoothWriteDataDefaultLength            = 120;

/** 默认链接设备 Identifier Key */
NSString * const kSwpBluetoothDefaultConnectionIdentifierKey    = @"kSwpBluetoothDefaultConnectionIdentifierKey";


@interface SwpBluetooth () <CBCentralManagerDelegate, CBPeripheralDelegate>


/* ---------------------- CBCentralManager  ---------------------- */
/** 中心管理器 */
@property (nonatomic, strong) CBCentralManager                      *centralManager;
/** 中心管理器 Options */
@property (nonatomic, copy  ) NSDictionary<NSString *, id>          *centralManagerOptions;;
/* ---------------------- CBCentralManager  ---------------------- */

/* ---------------------- Data    Property  ---------------------- */
/** 搜索到设备元数据  */
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *metaDatas;
/** 发现设备可写服务  */
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *writeChatacters;
/** 搜索到设备模型数据 */
@property (nonatomic, copy) NSArray<SwpBluetoothModel *>            *modelDatas;
/** 连接设备 Options  */
@property (nonatomic, copy) NSDictionary<NSString *, id>            *peripheralConnectOptions;
/* ---------------------- Data    Property  ---------------------- */


/* ---------------------- Block   Property  ---------------------- */
/** SwpBluetooth 回调方法，设备扫描调用 */
@property (nonatomic, copy) SwpBluetoothPeripheralBeginScanning     peripheralBeginScanning;
/**SwpBluetooth 回调方法，设备连接成功调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralSuccess    peripheralConnectSuccess;

/** SwpBluetooth 回调方法，接设备无法连，连接失败，调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralFail       peripheralConnectFail;
/** SwpBluetooth 回调方法，设备断开连接，调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralDisconnect peripheralDisconnect;
/**SwpBluetooth 回调方法，设备写入信息完成，调用 */
@property (nonatomic, copy) SwpBluetoothWriteDataCompletion         peripheralWriteDataCompletion;

/** SwpBluetooth 回调方法，设备自动连接成功，调用 */
@property (nonatomic, copy) SwpBluetoothConnectPeripheralSuccess    peripheralAutomaticlConnectSuccess;
/* ---------------------- Block   Property  ---------------------- */

/* ---------------------- Data    Property  ---------------------- */
/// 比较打印次数，数据过长需要分段写，因此 - (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error 该方法会调用多次
//  比较打印次数，和回调次数，两个相等，说明一次打印结束，完整洗完一次数据。
/** 写入数据，次数 */
@property (nonatomic, assign) NSInteger peripheralWriteDataCount;
/** 写入完成，返回次数 */
@property (nonatomic, assign) NSInteger peripheralWriteDataReturnCount;
/** 是否开启自动连接 */
@property (nonatomic, assign, getter = isPeripheralAutomaticlConnect) BOOL peripheralAutomaticlConnect;
/* ---------------------- Data    Property  ---------------------- */


@end

@implementation SwpBluetooth

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

            [central scanForPeripheralsWithServices:nil options:self.centralManagerOptions];
            
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
    
    //  数据处理
    self.metaDatas  = [SwpBluetoothUtils swpBluetoothUtilsScanDataFiltering:self.metaDatas central:central peripheral:peripheral advertisement:advertisementData RSSI:RSSI];
    self.modelDatas = [SwpBluetoothModel swpBluetoothWithDictionarys:self.metaDatas];
    
    
    
    if (self.peripheralBeginScanning) self.peripheralBeginScanning(self, self.modelDatas, self.metaDatas);
    
    
    //  是否自动连接
    if (!self.isPeripheralAutomaticlConnect) return;
    
    if ([peripheral.identifier.UUIDString isEqualToString:SwpBluetoothGetCache(kSwpBluetoothDefaultConnectionIdentifierKey)]) {
        [self connectPeripheral:peripheral];
    }

    
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
 
    [self.centralManager stopScan];
    
    _perpheral      = peripheral;
    _perpheralStage = SwpBluetoothPerpheralStageConnected;
    
    //  设置代理
    peripheral.delegate = self;
    
    //  发现服务
    [peripheral discoverServices:nil];
    
    //  数据处理
    self.metaDatas  = [SwpBluetoothUtils swpBluetoothUtilsUpdateDatas:self.metaDatas];
    self.modelDatas = [SwpBluetoothModel swpBluetoothWithDictionarys:self.metaDatas];
    
    //  缓存默认连接设备 identifier
    SwpBluetoothSetCache(kSwpBluetoothDefaultConnectionIdentifierKey, peripheral.identifier.UUIDString);
    
    if (self.peripheralConnectSuccess) self.peripheralConnectSuccess(self, peripheral, self.modelDatas, self.metaDatas);
    
    //  是否自动连接
    if (!self.isPeripheralAutomaticlConnect) return;
    
    if (self.peripheralAutomaticlConnectSuccess) self.peripheralAutomaticlConnectSuccess(self, peripheral, self.modelDatas, self.metaDatas);
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
    if (self.peripheralConnectFail) self.peripheralConnectFail(self, peripheral, error);
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
    
    self.metaDatas  = [SwpBluetoothUtils swpBluetoothUtilsUpdateDatas:self.metaDatas];
    self.modelDatas = [SwpBluetoothModel swpBluetoothWithDictionarys:self.metaDatas];
    if (self.peripheralDisconnect) self.peripheralDisconnect(self, peripheral, self.modelDatas, self.metaDatas, error);
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
        _perpheralStage      = SwpBluetoothPerpheralStageCharacteristics;
        self.writeChatacters = temp.copy;
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
 
    
    self.peripheralWriteDataReturnCount++;
    
    if (self.peripheralWriteDataReturnCount != self.peripheralWriteDataCount) return;
    
    //  完整写完一次数据
    if (error) {
        if (self.peripheralWriteDataCompletion) self.peripheralWriteDataCompletion(self, NO, peripheral, error, @"写入信息失败");
    } else {
        
        if (self.peripheralWriteDataCompletion) self.peripheralWriteDataCompletion(self, YES, peripheral, nil, nil);
    }
    
    
}

#pragma mark - Private Methods


/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothSetCache    ( 缓存数据 )
 *
 *  @param  key     key
 *
 *  @param  value   value
 *
 *  @return bool
 */
FOUNDATION_STATIC_INLINE bool SwpBluetoothSetCache(NSString *key, id value) {
    return [SwpBluetoothUtils swpBluetoothUtilsSetUserDefaults:value forKey:key];
}

/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothGetCache    ( 取出缓存数据 )
 *
 *  @param  key key
 *
 *  @return id
 */
FOUNDATION_STATIC_INLINE id SwpBluetoothGetCache(NSString *key) {
    return [SwpBluetoothUtils swpBluetoothUtilsGetUserDefaults:key];
}


/**
 *  @author swp_song
 *
 *  @brief  SwpBluetoothRemoveCache ( 移除缓存数据 )
 *
 *  @param  key key
 *
 *  @return bool
 */
FOUNDATION_STATIC_INLINE bool SwpBluetoothRemoveCache(NSString *key) {
    return [SwpBluetoothUtils swpBluetoothUtilsRemoveUserDefaults:key];
}

/**
 *  @author swp_song
 *
 *  @brief  connectPeripheral:  ( 连接设备 )
 *
 *  @param  peripheral  peripheral
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral {
    
    //  关闭之前的连接
    if (_perpheral) {
        [self cancelPeripheralConnection:_perpheral];
    }
    
    //  重新连接
    peripheral.delegate = self;
    [self.centralManager connectPeripheral:peripheral options:self.peripheralConnectOptions];
    
}

/**
 *  @author swp_song
 *
 *  @brief  cancelPeripheralConnection: ( 取消设备连接 )
 *
 *  @param  peripheral  peripheral
 */
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    
    if (!peripheral) return;
    
    //  移除默认连接缓存
    SwpBluetoothRemoveCache(kSwpBluetoothDefaultConnectionIdentifierKey);
    
    //  断开连接
    [self.centralManager cancelPeripheralConnection:peripheral];
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
 *
 *  @return NSInteger       返回一次数据，写入的次数
 */
- (NSInteger)_writeValue:(NSData *)data peripheral:(CBPeripheral *)peripheral dataLength:(NSInteger)length characteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type {
    
    
    NSInteger peripheralWriteDataCount = 0;
    
    if (length <= 0) {
        [peripheral writeValue:data forCharacteristic:characteristic type:type];
        peripheralWriteDataCount++;
        return peripheralWriteDataCount;
    }
    
    if (data.length <= length) {
        
        [peripheral writeValue:data forCharacteristic:characteristic type:type];
        peripheralWriteDataCount++;
        
        return peripheralWriteDataCount;
        
    } else {
        
        NSInteger index = 0;
        
        for (index = 0; index < data.length - length; index += length) {
            NSData *tempData = [data subdataWithRange:NSMakeRange(index, length)];
            [peripheral writeValue:tempData forCharacteristic:characteristic type:type];
            peripheralWriteDataCount++;
        }
        
        NSData *tempData = [data subdataWithRange:NSMakeRange(index, data.length - index)];
        if (tempData) {
            [peripheral writeValue:tempData forCharacteristic:characteristic type:type];
            peripheralWriteDataCount++;
        }
        
        return peripheralWriteDataCount;
    }
    
    return peripheralWriteDataCount;
}




#pragma mark - Public Methods
#pragma mark - SwpBluetooth 扫描设备
/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothManagerChain    ( 单利 )
 */
+ (__kindof SwpBluetooth * _Nonnull (^)(void))swpBluetoothManagerChain {
    return ^() {
        return [self.class swpBluetoothManager];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothStartScan   ( SwpBluetooth 开始扫描 )
 */
- (void)swpBluetoothStartScan {
    
    NSLog(@"开启扫描");
    self.metaDatas  = @[];
    self.modelDatas = @[];
    if (@available(iOS 10.0, *)) {
        if (self.centralManager.state == CBManagerStatePoweredOn) {
            //开启搜索
            [self.centralManager scanForPeripheralsWithServices:nil options:self.centralManagerOptions];
            return;
        }
        
    } else {
        
        if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
            //开启搜索
            [self.centralManager scanForPeripheralsWithServices:nil options:self.centralManagerOptions];
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
    [self.centralManager stopScan];
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
 *  @brief  swpBluetoothPeripheralBeginScanning:    ( SwpBluetooth， 回调方法，扫描设备调用 )
 *
 *  @param  beginScanning   beginScanning
 */
- (void)swpBluetoothPeripheralBeginScanning:(SwpBluetoothPeripheralBeginScanning)beginScanning {
    [self swpBluetoothStartScan];
    _peripheralBeginScanning = beginScanning;
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralBeginScanningChain    ( SwpBluetooth， 回调方法，扫描设备调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothPeripheralBeginScanning))swpBluetoothPeripheralBeginScanningChain {
    
    return ^(SwpBluetoothPeripheralBeginScanning beginScanning) {
        [self swpBluetoothPeripheralBeginScanning:beginScanning];
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
    [self connectPeripheral:peripheral];
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
    [self cancelPeripheralConnection:peripheral];
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
    return ^(SwpBluetoothConnectPeripheralDisconnect disconnect) {
        [self swpBluetoothPeripheralDisconnect:disconnect];
        return self;
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralAutomaticlConnect:    ( SwpBluetooth 设置自动连接蓝牙 )
 *
 *  @param  automaticlConnect   automaticlConnect
 */
- (void)swpBluetoothPeripheralAutomaticlConnect:(SwpBluetoothConnectPeripheralSuccess)automaticlConnect {
    self.peripheralAutomaticlConnect    = YES;
    _peripheralAutomaticlConnectSuccess = automaticlConnect;
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralAutomaticlConnectChain  ( SwpBluetooth 设置自动连接蓝牙 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothConnectPeripheralSuccess))swpBluetoothPeripheralAutomaticlConnectChain {
    return ^(SwpBluetoothConnectPeripheralSuccess automaticlConnect) {
        [self swpBluetoothPeripheralAutomaticlConnect:automaticlConnect];
        return self;
    };
}


#pragma mark - SwpBluetooth 写入数据
/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralWriteData:    ( SwpBluetooth 设备写入数据 )
 *
 *  @param  data    data
 */
- (void)swpBluetoothPeripheralWriteData:(NSData *)data {
   
    if (!self.perpheral) {
        NSLog(@"请链接打印机");
        return;
    }
    
    if (!self.writeChatacters.count) {
        NSLog(@"请检查打印机是否连接成功，打印服务是否可用");
        return;
    }
    
    if (_perpheralStage != SwpBluetoothPerpheralStageCharacteristics) {
        NSLog(@"打印机正在准备中...");
        return;
    }
    
    NSDictionary     *cachedData     = _writeChatacters.lastObject;
    CBCharacteristic *characteristic = cachedData[@"character"];
    CBCharacteristicWriteType type   = [cachedData[@"type"] integerValue];
    
    self.peripheralWriteDataCount        = 0;
    self.peripheralWriteDataReturnCount  = 0;
    self.peripheralWriteDataCount        = [self _writeValue:data peripheral:self.perpheral dataLength:kSwpBluetoothWriteDataDefaultLength characteristic:characteristic type:type];
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralWriteDataChain    ( SwpBluetooth 设备写入数据 )
 */
- (SwpBluetooth * _Nonnull (^)(NSData *))swpBluetoothPeripheralWriteDataChain {
    return ^(NSData *data) {
        [self swpBluetoothPeripheralWriteData:data];
        return self;
    };
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralWriteDataCompletion:  ( SwpBluetooth 回调方法，设备写入信息完成，调用 )
 *
 *  @param  writeDataCompletion writeDataCompletion
 */
- (void)swpBluetoothPeripheralWriteDataCompletion:(SwpBluetoothWriteDataCompletion)writeDataCompletion {
    _peripheralWriteDataCompletion = writeDataCompletion;
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPeripheralWriteDataCompletionChain  ( SwpBluetooth 回调方法，设备写入信息完成，调用 )
 */
- (SwpBluetooth * _Nonnull (^)(SwpBluetoothWriteDataCompletion))swpBluetoothPeripheralWriteDataCompletionChain {

    return ^(SwpBluetoothWriteDataCompletion writeDataCompletion) {
        [self swpBluetoothPeripheralWriteDataCompletion:writeDataCompletion];
        return self;
    };
}



#pragma Data Init Methods
- (CBCentralManager *)centralManager {
    return !_centralManager ? _centralManager = ({
        [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }) : _centralManager;
}

- (NSDictionary<NSString *,id> *)centralManagerOptions {
    
    return !_centralManagerOptions ? _centralManagerOptions = ({
        @{CBCentralManagerOptionShowPowerAlertKey : @(YES), CBCentralManagerScanOptionAllowDuplicatesKey : @(YES)};
    }) : _centralManagerOptions;
}

- (NSArray<NSDictionary<NSString *,id> *> *)metaDatas {
    return !_metaDatas ? _metaDatas = ({
        NSArray.new;
    }) : _metaDatas;
}

- (NSArray<NSDictionary<NSString *,id> *> *)writeChatacters {
    return !_writeChatacters ? _writeChatacters = ({
        NSArray.new;
    }) : _writeChatacters;
}

- (NSArray<SwpBluetoothModel *> *)modelDatas {
    return !_modelDatas ? _modelDatas = ({
        NSArray.new;
    }) : _modelDatas;
}

- (NSDictionary<NSString *,id> *)peripheralConnectOptions {
    return !_peripheralConnectOptions ? _peripheralConnectOptions = ({
        @{CBCentralManagerOptionShowPowerAlertKey : @(YES), CBConnectPeripheralOptionNotifyOnConnectionKey : @(YES), CBConnectPeripheralOptionNotifyOnDisconnectionKey : @(YES),CBConnectPeripheralOptionNotifyOnNotificationKey : @(YES)};
    }) : _peripheralConnectOptions;
}


@end
