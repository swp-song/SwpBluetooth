//
//  SwpBluetoothListViewController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothListViewController.h"

/* ---------------------- Tool       ---------------------- */
#import <SwpBluetooth/SwpBluetoothHeader.h>
#import <SwpCateGory/UIBarButtonItem+SwpSetNavigationBarItem.h>
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
#import "SwpBluetoothListView.h"
#import "SwpBluetoothListModel.h"
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

/* ---------------------- Controller ---------------------- */
#import "SwpBluetoothTempViewController.h"
/* ---------------------- Controller ---------------------- */


@interface SwpBluetoothListViewController ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
@property (nonatomic, strong) SwpBluetoothListView *swpBluetoothListView;
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
@property (nonatomic, copy  ) NSArray       *datas_;
@property (nonatomic, copy  ) CBPeripheral  *peripheral;
/* ---------------------- Data Property  ---------------------- */


@end

@implementation SwpBluetoothListViewController


#pragma mark - Lifecycle Methods
/**
 *  @author swp_song
 *
 *  @brief  viewDidLoad ( 视图载入完成, 调用 )
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#if TARGET_IPHONE_SIMULATOR
    
    [SVProgressHUD showInfoWithStatus:@"请使用真机运行"];
    
#elif TARGET_OS_IPHONE
    
    [self setUI];
    
    [self setData];
    
    [self swpBluetoothInit];
    
    __weak __typeof(self)weakSelf = self;
    self.swpBluetoothListView.swpBluetoothListViewClickCell(^(SwpBluetoothListView *swpBluetoothListView, NSIndexPath *indexPath, SwpBluetoothListModel *model){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf swpBluetoothConnect:model];
    });
    
#endif
  
    
}

/**
 *  @author swp_song
 *
 *  @brief  viewWillAppear: ( 将要加载出视图调用 )
 *
 *  @param  animated    animated
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    __weak __typeof(self)weakSelf = self;
    // 自动连接设备回调
    SwpBluetooth
    .swpBluetoothManagerChain()
    .swpBluetoothPeripheralAutomaticlConnectChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"「 %@ 」「 连接成功 」", perpheral.name]];
        strongSelf.peripheral = perpheral;

        [strongSelf swpBluetoothListViewDataRefresh:metaDatas];
    });
}

/**
 *  @author swp_song
 *
 *  @brief  viewDidAppear:  ( 视图显示窗口时调用 )
 *
 *  @param  animated    animated
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/**
 *  @author swp_song
 *
 *  @brief  viewWillDisappear:  ( 视图即将消失, 被覆盖, 隐藏时调用 )
 *
 *  @param  animated    animated
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
    [SVProgressHUD dismiss];
}

/**
 *  @author swp_song
 *
 *  @brief  viewDidDisappear:   ( 视图已经消失, 被覆盖, 隐藏时调用 )
 *
 *  @param  animated    animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    SwpBluetooth.swpBluetoothManagerChain().swpBluetoothStopScanChain();
}

/**
 *  @author swp_song
 *
 *  @brief  didReceiveMemoryWarning ( 内存不足时调用 )
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  @author swp_song
 *
 *  @brief  dealloc ( 当前控制器被销毁时调用 )
 */
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Set Data Method
/**
 *  @author swp_song
 *
 *  @brief  setData ( 设置 初始化 数据 )
 */
- (void)setData {
    
}

#pragma mark - Set UI Methods
/**
 *  @author swp_song
 *
 *  @brief  setUI   ( 设置 UI 控件 )
 */
- (void)setUI {
    [self setNavigationBar];
    [self setUpUI];
    [self setUIAutoLayout];
}


/**
 *  @author swp_song
 *
 *  @brief  setNavigationBar    ( 设置导航栏 )
 */
- (void)setNavigationBar {
    
    [self navigationBarTitle:@"蓝牙列表" textColor:nil titleFontSize:nil];
    
    UIBarButtonItem *jumpButtonItem = [UIBarButtonItem swpSetNavigationBarItemTitle:@"Jump" setFontColot:[UIColor blackColor] setFontSize:15 setTag:0 setLeftBarButtonItem:NO setAarget:self setAction:@selector(clickJumpButtonItemEvent:)];
    
    UIBarButtonItem *printButtonItem = [UIBarButtonItem swpSetNavigationBarItemTitle:@"Print" setFontColot:[UIColor blackColor] setFontSize:15 setTag:0 setLeftBarButtonItem:NO setAarget:self setAction:@selector(clickPrintButtonItemEvent:)];
    
    self.navigationItem.rightBarButtonItems = @[jumpButtonItem, printButtonItem];
    
}

/**
 *  @author swp_song
 *
 *  @brief  setUpUI ( 添加控件 )
 */
- (void)setUpUI {
    
    [self.view addSubview:self.swpBluetoothListView];
}

/**
 *  @author swp_song
 *
 *  @brief  setUIAutoLayout ( 设置控件的自动布局 )
 */
- (void)setUIAutoLayout {
    
    [self.swpBluetoothListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


/**
 *  @author swp_song
 *
 *  @brief  clickJumpButtonItemEvent:   ( 跳转按钮绑定方法 )
 *
 *  @param  buttonItem  buttonItem
 */
- (void)clickJumpButtonItemEvent:(UIBarButtonItem *)buttonItem {
    [self.navigationController pushViewController:SwpBluetoothTempViewController.new animated:YES];
}


/**
 *  @author swp_song
 *
 *  @brief  clickPrintButtonItemEvent:  ( 打印按钮绑定方法 )
 *
 *  @param  buttonItem  buttonItem
 */
- (void)clickPrintButtonItemEvent:(UIBarButtonItem *)buttonItem {
    NSString *pringString = [NSString stringWithFormat:@"[ %@ ] 「 已连接 」", self.peripheral.name];
    SwpBluetooth.swpBluetoothManagerChain().swpBluetoothPeripheralWriteDataChain(SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData);
}



/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothInit:   ( SwpBluetooth 设置 )
 */
- (void)swpBluetoothInit {
    
    __weak __typeof(self)weakSelf = self;
    
    SwpBluetooth
    //  初始化
    .swpBluetoothManagerChain()
    //  扫描设备
    .swpBluetoothPeripheralBeginScanningChain(^(SwpBluetooth * _Nonnull swpBluetooth, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf swpBluetoothListViewDataRefresh:metaDatas];
    })
    //  设备断开链接回调
    .swpBluetoothPeripheralDisconnectChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf swpBluetoothListViewDataRefresh:metaDatas];
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"「 %@ 」「 断开连接 」", perpheral.name]];
    })
    //  无法链接设备回调
    .swpBluetoothConnectPeripheralFailChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSError * _Nonnull error){
        
    })
    
    //  设备写入数据
    .swpBluetoothPeripheralWriteDataCompletionChain(^(SwpBluetooth *swpBluetooth, BOOL completion, CBPeripheral * _Nonnull perpheral, NSError * _Nullable error, NSString * _Nullable errorMessage){
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"「 %@ 」「 %@ 」", perpheral.name, completion ? @"写入成功" : @"写入失败"]];
    });
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothConnect:    ( 连接蓝牙方法 )
 *
 *  @param  model   model
 */
- (void)swpBluetoothConnect:(SwpBluetoothListModel *)model {

    __weak __typeof(self)weakSelf = self;
    
    SwpBluetooth
    .swpBluetoothManagerChain()
    //  连接设备，成功回调
    .swpBluetoothConnectPeripheralChain(model.peripheral, ^(SwpBluetooth *swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull datas){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        
        strongSelf.peripheral =  perpheral;
        
        [strongSelf swpBluetoothListViewDataRefresh:datas];
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"「 %@ 」「 连接成功 」", perpheral.name]];
        
    });
    
}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothListViewDataRefresh:    ( 数据刷新 )
 *
 *  @param  datas   datas
 */
- (void)swpBluetoothListViewDataRefresh:(NSArray *)datas {
    self.datas_ = [SwpBluetoothListModel swpBluetoothListWithDictionarys:datas];
    self.swpBluetoothListView.datas(self.datas_);
}


#pragma mark - Init UI Methods
- (SwpBluetoothListView *)swpBluetoothListView {

    return !_swpBluetoothListView ? _swpBluetoothListView = ({
        SwpBluetoothListView.new;
    }) : _swpBluetoothListView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
