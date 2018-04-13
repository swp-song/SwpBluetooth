//
//  SwpBluetoothUtils.m
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothUtils.h"

#import <CoreBluetooth/CoreBluetooth.h>

@implementation SwpBluetoothUtils

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
+ (NSArray<NSDictionary *> *)swpBluetoothUtilsScanDataFiltering:(NSArray *)datas central:(CBCentralManager *)central peripheral:(CBPeripheral *)peripheral advertisement:(NSDictionary<NSString *, id> *)advertisement RSSI:(NSNumber *)RSSI {
    
    
    NSMutableArray *dataSource = datas.mutableCopy;
    
    if (dataSource.count == 0) {
        
        NSDictionary *data = [self.class createBluetoothDictonary:peripheral advertisement:advertisement RSSI:RSSI];
        [dataSource addObject:data];
        
    } else {
        __block BOOL isExist = NO;
        [dataSource enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CBPeripheral *per = obj[@"peripheral"];
            if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                isExist = YES;
                NSDictionary *data = [self.class createBluetoothDictonary:peripheral advertisement:advertisement RSSI:RSSI];
                [dataSource replaceObjectAtIndex:idx withObject:data];
            }
        }];
        
        if (!isExist) {
            NSDictionary *data = [self.class createBluetoothDictonary:peripheral advertisement:advertisement RSSI:RSSI];
            [dataSource addObject:data];
        }
    }
    return dataSource.copy;
    
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsUpdateDatas:   ( 设备数据过滤 )
 *
 *  @param  datas   datas
 *
 *  @return NSArray
 */
+ (NSArray<NSDictionary *> *)swpBluetoothUtilsUpdateDatas:(NSArray<NSDictionary<NSString *, id> *> *)datas {
    
    NSMutableArray *temp = NSMutableArray.new;
    
    [datas enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dictionary  = obj.mutableCopy;
        CBPeripheral        *_peripheral = dictionary[@"peripheral"];
        [dictionary setObject:@(_peripheral.state) forKey:@"state"];
        [temp addObject:dictionary.copy];
    }];
    
    return temp.copy;
}



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
+ (BOOL)swpBluetoothUtilsSetUserDefaults:(id)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    return [userDefaults synchronize];
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsGetUserDefaults:   ( NSUserDefaults 取 )
 *
 *  @param  key key
 *
 *  @return id
 */
+ (id)swpBluetoothUtilsGetUserDefaults:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothUtilsRemoveUserDefaults:    ( NSUserDefaults 移除 )
 *
 *  @param  key key
 *
 *  @return BOOL
 */
+ (BOOL)swpBluetoothUtilsRemoveUserDefaults:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    return [userDefaults synchronize];
}


#pragma mark - Privare Methods
/**
 *  @author swp_song
 *
 *  @brief  createBluetoothDictonary:advertisement:RSSI:    ( 创建一个蓝牙数据字典 )
 *
 *  @param  peripheral      peripheral
 *
 *  @param  advertisement   advertisement
 *
 *  @param  RSSI            RSSI
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)createBluetoothDictonary:(CBPeripheral *)peripheral advertisement:(NSDictionary<NSString *,id> *)advertisement RSSI:(NSNumber *)RSSI {
    
    
    NSMutableDictionary        *dictionary          = NSMutableDictionary.new;
    NSArray<NSUUID *>          *serviceUUIDs        = NSMutableArray.new;
    NSMutableArray<NSString *> *serviceUUIDStrings  = NSMutableArray.new;
    
    if (advertisement[@"kCBAdvDataServiceUUIDs"]) {
        serviceUUIDs = advertisement[@"kCBAdvDataServiceUUIDs"];
        [serviceUUIDs enumerateObjectsUsingBlock:^(NSUUID * _Nonnull uuid, NSUInteger idx, BOOL * _Nonnull stop) {
            [serviceUUIDStrings addObject:uuid.UUIDString];
        }];
        [dictionary setObject:serviceUUIDs forKey:@"serviceUUIDs"];
        [dictionary setObject:serviceUUIDStrings forKey:@"stringServiceUUIDs"];
    }
    
    [dictionary setObject:RSSI forKey:@"RSSI"];
    [dictionary setObject:peripheral.name forKey:@"name"];
    [dictionary setObject:peripheral forKey:@"peripheral"];
    [dictionary setObject:advertisement forKey:@"advertisement"];
    [dictionary setObject:peripheral.identifier forKey:@"identifier"];
    [dictionary setObject:@(peripheral.state) forKey:@"state"];
    
    return dictionary.copy;
}

@end
