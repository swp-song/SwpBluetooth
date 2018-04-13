//
//  SwpBluetoothBase.m
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothBase.h"

static id _swpBluetoothBase;

@interface SwpBluetoothBase ()

@end

@implementation SwpBluetoothBase

#pragma mark - Override Methods
/**
 *  @author swp_song
 *
 *  @brief  allocWithZone:  ( Override  allocWithZone )
 *
 *  @param  zone    zone
 *
 *  @return id
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _swpBluetoothBase = [super allocWithZone:zone];
    });
    return _swpBluetoothBase;
}

/**
 *  @author swp_song
 *
 *  @brief  copyWithZone:   ( Override  copyWithZone )
 *
 *  @param  zone    zone
 *
 *  @return id
 */
- (id)copyWithZone:(NSZone *)zone {
    return  _swpBluetoothBase;
}

/**
 *  @author swp_song
 *
 *  @brief  mutableCopyWithZone:    ( Override  mutableCopyWithZone )
 *
 *  @param  zone    zone
 *
 *  @return id
 */
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _swpBluetoothBase;
}

#pragma mark - Public Methods
/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothManager ( 单利方法, 快速初始化 )
 *
 *  @return SwpBluetoothBase
 */
+ (instancetype)swpBluetoothManager {
    return [self new];
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothInfo    ( SwpBluetooth 信息 )
 *
 *  @return NSDictionary
 */
- (NSDictionary *)swpBluetoothInfo {
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"SwpBluetooth.bundle/SwpBluetooth.plist" ofType:nil]];
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothVersion  ( SwpBluetooth 版本号 )
 *
 *  @return NSString
 */
- (NSString *)swpBluetoothVersion {
    return self.swpBluetoothInfo[@"Version"];
}

@end
