//
//  SwpBluetoothListView.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothListView : UITableView

/**
 *  @author swp_song
 *
 *  @brief  datas   ( 设置数据源 )
 */
- (SwpBluetoothListView * _Nonnull (^)(NSArray * _Nonnull))datas;

- (SwpBluetoothListView * _Nonnull (^)(void (^ _Nullable)(SwpBluetoothListView * _Nonnull, NSIndexPath * _Nonnull)))swpBluetoothListViewClickCell;


- (void)datas:(NSArray *)datas;


@end
NS_ASSUME_NONNULL_END
