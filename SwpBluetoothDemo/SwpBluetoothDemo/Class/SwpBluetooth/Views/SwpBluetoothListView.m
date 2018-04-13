
//
//  SwpBluetoothListView.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothListView.h"


/* ---------------------- Tool       ---------------------- */
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
#import "SwpBluetoothListCell.h"
/* ---------------------- View       ---------------------- */


@interface SwpBluetoothListView () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* 数据源 */
@property (nonatomic, copy) NSArray *datas_;
@property (nonatomic, copy) void(^clickCell)(SwpBluetoothListView *, NSIndexPath *, SwpBluetoothListModel *);
/* ---------------------- Data Property  ---------------------- */
@end


@implementation SwpBluetoothListView


/**
 *  @author swp_song
 *
 *  @brief  initWithFrame:style:    ( Override Init )
 *
 *  @param  frame   frame
 *
 *  @param  style   style
 *
 *  @return UITableView
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self registerClass:SwpBluetoothListCell.class forCellReuseIdentifier:NSStringFromClass(SwpBluetoothListCell.class)];
        self.dataSource      = self;
        self.delegate        = self;
//        self.backgroundColor = [UIColor whiteColor];
//        self.separatorStyle  = UITableViewCellSeparatorStyleNone;
//        self.scrollEnabled   = NO;;
    }
    return self;
}

/**
 *  @author swp_song
 *
 *  @brief  numberOfSectionsInTableView:    ( tableView 数据源方法 设置 tableView 分组个数 )
 *
 *  @param  tableView  tableView
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *  @author swp_song
 *
 *  @brief  tableView:numberOfRowsInSection:    ( tableView 数据源方法 设置 tableView 分组中cell显示的个数 )
 *
 *  @param  tableView   tableView
 *
 *  @param  section     section
 *
 *  @return NSInteger
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas_.count;
}

/**
 *  @author swp_song
 *
 *  @brief  tableView:cellForRowAtIndexPath:    ( tableView 数据源方法设置 tableView 分组中cell显示的数据 | 样式)
 *
 *  @param  tableView   tableView
 *
 *  @param  indexPath   indexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SwpBluetoothListCell.swpBluetoothListCellInit(tableView, NSStringFromClass(SwpBluetoothListCell.class)).swpBluetoothList(self.datas_[indexPath.row]);
}

#pragma mark - UITableView Delegate Methods
/**
 *  @author swp_song
 *
 *  @brief  tableView:didSelectRowAtIndexPath:  ( tableView 代理方法 点击每个cell调用 )
 *
 *  @param  tableView   tableView
 *
 *  @param  indexPath   indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (self.clickCell) self.clickCell(self, indexPath, self.datas_[indexPath.row]);
}


#pragma mark - Public Methods
/**
 *  @author swp_song
 *
 *  @brief  datas   ( 设置数据源 )
 */
- (SwpBluetoothListView * _Nonnull (^)(NSArray * _Nonnull))datas {
    
    return ^(NSArray *datas) {
        self.datas_ = datas;
        [self reloadData];
        return self;
    };
}

/**
 *  @author swp_song
 *
 *  @brief  tableView:swpBluetoothListViewClickCell ( SwpBluetoothListView 回调方法，点击 cell 调用)
 */
- (SwpBluetoothListView * _Nonnull (^)(void (^ _Nonnull)(SwpBluetoothListView * _Nonnull, NSIndexPath * _Nonnull, SwpBluetoothListModel * _Nonnull)))swpBluetoothListViewClickCell {
    
    return ^(void(^clickCell)(SwpBluetoothListView *, NSIndexPath *, SwpBluetoothListModel *)) {
        self.clickCell = clickCell;
        return self;
    };
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
