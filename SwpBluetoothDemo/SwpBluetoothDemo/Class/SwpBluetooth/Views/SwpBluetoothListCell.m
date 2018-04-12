
//
//  SwpBluetoothListCell.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothListCell.h"

/* ---------------------- Tool       ---------------------- */
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
#import "SwpBluetoothListModel.h"
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

@interface SwpBluetoothListCell ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* ---------------------- Data Property  ---------------------- */


@end

@implementation SwpBluetoothListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  @author swp_song
 *
 *  @brief  initWithStyle:reuseIdentifier: ( Override Init )
 *
 *  @param  style               style
 *
 *  @param  reuseIdentifier     reuseIdentifier
 *
 *  @return ZjUserInputCell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        [self setUIAutoLayout];
        
    
    }
    return self;
}



/**
 *  @author swp_song
 *
 *  @brief  setUpUI ( 添加控件 )
 */
- (void)setUpUI {
    
}

/**
 *  @author swp_song
 *
 *  @brief  setUIAutoLayout ( 设置控件的自动布局 )
 */
- (void)setUIAutoLayout {
    
}

/**
 *  @author swp_song
 *
 *  @brief  setData:    ( 设置数据 )
 *
 *  @param  swpBluetoothList    swpBluetoothList
 */
- (void)setData:(SwpBluetoothListModel *)swpBluetoothList {
    self.textLabel.text       = swpBluetoothList.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@", swpBluetoothList.RSSI];
    self.accessoryType        = swpBluetoothList.state == SwpBluetoothListtateConnected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

#pragma mark - Public Methods
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
+ (instancetype)swpBluetoothListCellWihtTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier {
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListCellInit ( 快速初始化一个 Cell )
 */
+ (__kindof SwpBluetoothListCell * _Nonnull (^)(UITableView * _Nonnull, NSString * _Nonnull))swpBluetoothListCellInit {
    
    return ^(UITableView *tableView, NSString *identifier) {
        return [self.class swpBluetoothListCellWihtTableView:tableView forCellReuseIdentifier:identifier];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothList    ( 设置数据 )
 */
- (SwpBluetoothListCell * _Nonnull (^)(SwpBluetoothListModel * _Nonnull))swpBluetoothList {
    
    return ^(SwpBluetoothListModel *swpBluetoothList) {
        [self setData:swpBluetoothList];
        return self;
    };
}


@end
