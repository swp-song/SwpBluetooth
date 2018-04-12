//
//  SwpBluetoothListCell.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SwpBluetoothListModel;


NS_ASSUME_NONNULL_BEGIN

@interface SwpBluetoothListCell : UITableViewCell

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListCellWihtTableView:forCellReuseIdentifier:   ( 快速初始化一个 Cell )
 *
 *  @param  tableView       tableView
 *
 *  @param  identifier      identifier
 *
 *  @return UITableViewCell
 */
+ (instancetype)swpBluetoothListCellWihtTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListCellInit ( 快速初始化一个 Cell )
 */
+ (__kindof SwpBluetoothListCell * _Nonnull (^)(UITableView * _Nonnull, NSString * _Nonnull))swpBluetoothListCellInit;

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothList    ( 设置数据 )
 */
- (SwpBluetoothListCell * _Nonnull (^)(SwpBluetoothListModel * _Nonnull))swpBluetoothList;



@end
NS_ASSUME_NONNULL_END
