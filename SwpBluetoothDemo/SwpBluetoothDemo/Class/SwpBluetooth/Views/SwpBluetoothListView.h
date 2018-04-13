//
//  SwpBluetoothListView.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwpBluetoothListModel;
NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothListView : UITableView

/**
 *  @author swp_song
 *
 *  @brief  datas   ( 设置数据源 )
 */
- (SwpBluetoothListView * _Nonnull (^)(NSArray * _Nonnull))datas;

/**
 *  @author swp_song
 *
 *  @brief  tableView:swpBluetoothListViewClickCell ( SwpBluetoothListView 回调方法，点击 cell 调用)
 */
- (SwpBluetoothListView * _Nonnull (^)(void (^ _Nonnull)(SwpBluetoothListView * _Nonnull, NSIndexPath * _Nonnull, SwpBluetoothListModel * _Nonnull)))swpBluetoothListViewClickCell;

@end
NS_ASSUME_NONNULL_END
