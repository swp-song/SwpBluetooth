//
//  SwpBluetoothBase.h
//  song_song
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SwpBluetoothDatas.h"

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothBase : NSObject

/**
 *  @author swp_song
 *
 *  @brief  sharedInstance   ( 单利方法, 快速初始化 )
 *
 *  @return SwpBluetoothBase
 */
+ (instancetype)sharedInstance;


@end
NS_ASSUME_NONNULL_END
