
//
//  SwpBluetoothMethodTestViewController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothMethodTestViewController.h"

/* ---------------------- Tool       ---------------------- */
#import <SwpBluetooth/SwpBluetooth.h>
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

/* ---------------------- Controller ---------------------- */
/* ---------------------- Controller ---------------------- */


@interface SwpBluetoothMethodTestViewController ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* ---------------------- Data Property  ---------------------- */


@end

@implementation SwpBluetoothMethodTestViewController


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
    
    [self testSwpBluetooth];
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
 *  @brief  testSwpBluetoothManager ( 设置控件的自动布局 )
 */
- (void)testSwpBluetooth {
    
    [SVProgressHUD dismiss];
    
    SwpBluetooth *b0     = [SwpBluetooth new];
    SwpBluetooth *b1     = [[SwpBluetooth alloc] init];
    SwpBluetooth *b2     = [SwpBluetooth swpBluetoothManager];
    SwpBluetooth *b3     = SwpBluetooth.swpBluetoothManagerChain();
    SwpBluetooth *b4     = SwpBluetooth.new;
    SwpBluetooth *b5     = b0.copy;
    SwpBluetooth *b6     = b0.mutableCopy;
    SwpBluetooth *b7     = b1.copy;
    SwpBluetooth *b8     = b1.mutableCopy;
    SwpBluetooth *b9     = b2.copy;
    SwpBluetooth *b10    = b2.mutableCopy;
    SwpBluetooth *b11    = b3.copy;
    SwpBluetooth *b12    = b3.mutableCopy;
    SwpBluetooth *b13    = b4.copy;
    SwpBluetooth *b14    = b4.mutableCopy;
    
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@" 内存地址「 %p 」更多请查看控制台打印信息。", b0]];
    NSLog(@"b0 = %p, b1 = %p, b2 = %p, b3 = %p, b4 = %p, b5 = %p, b6 = %p, b7 = %p, b8 = %p, b9 = %p, b10 = %p, b11 = %p, b12 = %p, b13 = %p, b14 = %p ", b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14);
    
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"b0 = %p, b1 = %p, b2 = %p, b3 = %p, b4 = %p, b5 = %p, b6 = %p, b7 = %p, b8 = %p, b9 = %p, b10 = %p, b11 = %p, b12 = %p, b13 = %p, b14 = %p ", b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14]];
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
