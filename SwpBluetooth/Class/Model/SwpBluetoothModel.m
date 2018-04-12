//
//  SwpBluetoothModel.m
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothModel.h"

@implementation SwpBluetoothModel


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothModel
 */
+ (instancetype)swpBluetoothWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


/**
 *  @author swp_song
 *
 *  @brief  initWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothModel
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        _metaDatas          = dictionary.copy;
        _RSSI               = _metaDatas[@"RSSI"];
        _advertisement      = _metaDatas[@"advertisement"];
        _identifier         = _metaDatas[@"identifier"];
        _name               = _metaDatas[@"name"];
        _peripheral         = _metaDatas[@"peripheral"];
        _serviceUUIDs       = _metaDatas[@"serviceUUIDs"] ? _metaDatas[@"serviceUUIDs"] : NSArray.new;
        _stringServiceUUIDs = _metaDatas[@"stringServiceUUIDs"] ? _metaDatas[@"stringServiceUUIDs"] : NSArray.new;
    }
    return self;
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothWithDictionarys:    ( 数据转换 )
 *
 *  @param  dictionarys dictionarys
 *
 *  @return SwpBluetoothModel
 */
+ (NSArray<SwpBluetoothModel *> *)swpBluetoothWithDictionarys:(NSArray<NSDictionary<NSString *, id> *> *)dictionarys {
    
    NSMutableArray<SwpBluetoothModel *> *models = NSMutableArray.new;
    [dictionarys enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        [models addObject:[self.class swpBluetoothWithDictionary:dictionary]];
    }];

    return models.copy;
}


@end
