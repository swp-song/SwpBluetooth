
//
//  SwpBluetoothListModel.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothListModel.h"


@implementation SwpBluetoothListModel



/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothListModel
 */
+ (instancetype)swpBluetoothListWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


/**
 *  @author swp_song
 *
 *  @brief  initWithDictionary: ( 数据转换 )
 *
 *  @param  dictionary  dictionary
 *
 *  @return SwpBluetoothListModel
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        _metaDatas          = dictionary.copy;
        _RSSI               = _metaDatas[@"RSSI"];
        _advertisement      = _metaDatas[@"advertisement"];
        _identifier         = _metaDatas[@"identifier"];
        _name               = _metaDatas[@"name"];
        _peripheral         = _metaDatas[@"peripheral"];
        _state              = [_metaDatas[@"state"] integerValue];
    }
    return self;
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListWithDictionarys:    ( 数据转换 )
 *
 *  @param  dictionarys dictionarys
 *
 *  @return SwpBluetoothListModel
 */
+ (NSArray<SwpBluetoothListModel *> *)swpBluetoothListWithDictionarys:(NSArray<NSDictionary<NSString *, id> *> *)dictionarys {
    
    NSMutableArray<SwpBluetoothListModel *> *models = NSMutableArray.new;
    [dictionarys enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        [models addObject:[self.class swpBluetoothListWithDictionary:dictionary]];
    }];
    
    return models.copy;
}

@end

