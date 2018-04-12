//
//  SwpBluetoothRootViewController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothRootViewController.h"

/* ---------------------- Tool       ---------------------- */
#import <SwpBluetooth/SwpBluetoothHeader.h>
#import <SwpBluetooth/SwpPrint.h>
#import <SwpCateGory/UIColor+SwpColor.h>
#import <SwpCateGory/UIButton+SwpSetButton.h>
#import <SwpCateGory/UIBarButtonItem+SwpSetNavigationBarItem.h>
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

/* ---------------------- Controller ---------------------- */
#import "SwpBluetoothListViewController.h"
#import "SwpBluetoothMethodTestViewController.h"
/* ---------------------- Controller ---------------------- */

@interface SwpBluetoothRootViewController ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
@property (nonatomic, strong) UIButton *bluetoothListButton;
@property (nonatomic, strong) UIButton *bluetoothMethodTestButton;
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* ---------------------- Data Property  ---------------------- */


@end

@implementation SwpBluetoothRootViewController

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
    [self navigationBarTitle:@"蓝牙Demo" textColor:nil titleFontSize:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem swpSetNavigationBarItemTitle:@"Jump" setFontColot:[UIColor blackColor] setFontSize:15 setTag:0 setLeftBarButtonItem:NO setAarget:self setAction:@selector(clickButtonItemEvent:)];
}

/**
 *  @author swp_song
 *
 *  @brief  setUpUI ( 添加控件 )
 */
- (void)setUpUI {
    
    [self.view addSubview:self.bluetoothListButton];
    [self.view addSubview:self.bluetoothMethodTestButton];
}

/**
 *  @author swp_song
 *
 *  @brief  setUIAutoLayout ( 设置控件的自动布局 )
 */
- (void)setUIAutoLayout {
    
    
    [self.bluetoothListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).mas_equalTo(UIEdgeInsetsMake(80, 10, 0, 10));
        make.width.equalTo(self.bluetoothListButton.mas_height).multipliedBy(11.0);
    }];
    
    [UIButton swpSetButtonSubmitStyle:self.bluetoothListButton setBackgroundColor:UIColor.swpColorWithRandom() setFontColor:[UIColor whiteColor] setTitle:@"蓝牙列表" setFontSize:14 setCornerRadius:0 setTag:0 setTarget:self setAction:@selector(clickBluetoothListButtonEvent:)];
    
    
    [self.bluetoothMethodTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.bluetoothListButton);
        make.top.equalTo(self.bluetoothListButton.mas_bottom).offset(50);
    }];
    
    
    [UIButton swpSetButtonSubmitStyle:self.bluetoothMethodTestButton setBackgroundColor:UIColor.swpColorWithRandom() setFontColor:[UIColor whiteColor] setTitle:@"方法测试" setFontSize:14 setCornerRadius:0 setTag:0 setTarget:self setAction:@selector(clickBluetoothMethodTestButtonButtonEvent:)];
}


- (void)clickBluetoothListButtonEvent:(UIButton *)button {
    [self.navigationController pushViewController:SwpBluetoothListViewController.new animated:YES];
}


- (void)clickBluetoothMethodTestButtonButtonEvent:(UIButton *)button {
    [self.navigationController pushViewController:SwpBluetoothMethodTestViewController.new animated:YES];
}

- (void)clickButtonItemEvent:(UIBarButtonItem *)buttonItem {
    //    [self.navigationController pushViewController:SwpBluetoothTempViewController.new animated:YES];
    
    //    [sendPrintData]
    
    if (SwpBluetooth.sharedInstanceInit().perpheralStage != SwpBluetoothPerpheralStageCharacteristics) {
        //        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        
        return;
    }
    NSString *pringString = [NSString stringWithFormat:@"设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接成功设备链接"];
    //    SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData;
    
    [SwpBluetooth.sharedInstanceInit() sendPrintData:SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData];
//    [self.swpBluetooth sendPrintData:SwpPrint.initSwpPrint().swpPrintEndCustomText(pringString).swpPrinterData];
}



- (UIButton *)bluetoothListButton {
    return !_bluetoothListButton ? _bluetoothListButton = ({
        [UIButton buttonWithType:UIButtonTypeCustom];
    }) : _bluetoothListButton;
}

- (UIButton *)bluetoothMethodTestButton {
    return !_bluetoothMethodTestButton ? _bluetoothMethodTestButton = ({
        [UIButton buttonWithType:UIButtonTypeCustom];
    }) : _bluetoothMethodTestButton;
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
