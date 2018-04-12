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
#import <SwpBluetooth/SwpPrint.h>
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
@property (nonatomic, copy  ) NSArray *datas_;
@property (nonatomic, strong) SwpBluetooth *swpBluetooth;
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
    
    [self setUI];
    
    [self setData];
    

    __weak __typeof(self)weakSelf = self;
    self.swpBluetooth = SwpBluetooth
    .sharedInstanceInit();
    
    self.swpBluetooth =
    SwpBluetooth
    .sharedInstanceInit()
    .swpBluetoothScanningChain(^(NSArray<SwpBluetoothModel *> *models, NSArray<NSDictionary<NSString *,id> *> *datas){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        strongSelf.datas_ = [SwpBluetoothListModel swpBluetoothListWithDictionarys:datas];
        strongSelf.swpBluetoothListView.datas(strongSelf.datas_);
    })
    .swpBluetoothPeripheralDisconnectChain(^(CBPeripheral *perpheral, NSError *error){
        
    });
    
    
    
    self.swpBluetoothListView.swpBluetoothListViewClickCell(^(SwpBluetoothListView *swpBluetoothListView, NSIndexPath *indexPath){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf swpBluetoothConnect:strongSelf.swpBluetooth model:strongSelf.datas_[indexPath.row]];
    });
    
    
    
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
    
    self.swpBluetooth.swpBluetoothStartScanChain();
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
    self.swpBluetooth.swpBluetoothStopScanChain();
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
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem swpSetNavigationBarItemTitle:@"Jump" setFontColot:[UIColor blackColor] setFontSize:15 setTag:0 setLeftBarButtonItem:NO setAarget:self setAction:@selector(clickButtonItemEvent:)];
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


- (void)clickButtonItemEvent:(UIBarButtonItem *)buttonItem {
//    [self.navigationController pushViewController:SwpBluetoothTempViewController.new animated:YES];
    
//    [sendPrintData]
    
    if (self.swpBluetooth.perpheralStage != SwpBluetoothPerpheralStageCharacteristics) {
//        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        
        return;
    }
    NSString *pringString = [NSString stringWithFormat:@"设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接"];
//    SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData;
    [self.swpBluetooth sendPrintData:SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData];
}

- (void)swpBluetoothConnect:(SwpBluetooth *)swpBluetooth model:(SwpBluetoothListModel *)model {

    __weak __typeof(self)weakSelf = self;
    
//    [swpBluetooth swpBluetoothConnectPeripheral:model.peripheral connectSuccess:^(CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull datas) {
//
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        strongSelf.datas_ = [SwpBluetoothListModel swpBluetoothListWithDictionarys:datas];
//        strongSelf.swpBluetoothListView.datas(strongSelf.datas_);
//    }];
    
    swpBluetooth.swpBluetoothConnectPeripheralChain(model.peripheral, ^(CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull datas){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.datas_ = [SwpBluetoothListModel swpBluetoothListWithDictionarys:datas];
        strongSelf.swpBluetoothListView.datas(strongSelf.datas_);
    });
}



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
