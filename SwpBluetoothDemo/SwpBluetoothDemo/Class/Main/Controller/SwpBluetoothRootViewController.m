//
//  SwpBluetoothRootViewController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothRootViewController.h"

/* ---------------------- Tool       ---------------------- */
#import <SwpCateGory/UIColor+SwpColor.h>
#import <SwpBluetooth/SwpBluetoothHeader.h>
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
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem swpSetNavigationBarItemTitle:@"Print" setFontColot:[UIColor blackColor] setFontSize:15 setTag:0 setLeftBarButtonItem:NO setAarget:self setAction:@selector(clickPrintButtonItemEvent:)];
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



/**
 *  @author swp_song
 *
 *  @brief  clickBluetoothListButtonEvent:  ( )
 *
 *  @param  button  button
 */
- (void)clickBluetoothListButtonEvent:(UIButton *)button {
    [self.navigationController pushViewController:SwpBluetoothListViewController.new animated:YES];
}


/**
 *  @author swp_song
 *
 *  @brief  clickBluetoothMethodTestButtonButtonEvent:  (  )
 *
 *  @param  button  button
 */
- (void)clickBluetoothMethodTestButtonButtonEvent:(UIButton *)button {
    [self.navigationController pushViewController:SwpBluetoothMethodTestViewController.new animated:YES];
}


/**
 *  @author swp_song
 *
 *  @brief  clickPrintButtonItemEvent:  ( 打印按钮绑定方法 )
 *
 *  @param  buttonItem  buttonItem
 */
- (void)clickPrintButtonItemEvent:(UIBarButtonItem *)buttonItem {
    
    
    
#if TARGET_IPHONE_SIMULATOR
    [SVProgressHUD dismiss];
    [SVProgressHUD showInfoWithStatus:@"请使用真机运行"];
    
#elif TARGET_OS_IPHONE
    
    [self swpBluetoothPrint];
    
#endif

}


/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothPrint   ( 排版打印 )
 */
- (void)swpBluetoothPrint {
    
    SwpPrint *swpPrint = SwpPrint.initSwpPrint();
    //  头部排版
    swpPrint.swpPrintSetTitle(SwpTextAlignmentCenter, @"SwpBluetoothDemo").swpPrintSeparateLinesStyle2();
    swpPrint.swpPrintSetTitle(SwpTextAlignmentCenter, @"蓝牙打印Demo").swpPrintSeparateLinesStyle2();
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentCenter, SwpFontSizeMiddle, @"商家名称").swpPrintSeparateLinesStyle1();
    swpPrint.swpPrintSetText(SwpTextAlignmentLeft, @"订单编号：1234567890");
    swpPrint.swpPrintSetText(SwpTextAlignmentLeft, @"送达时间：2018-04-13 17:44:22").swpPrintSeparateLinesStyle1();
    
    //  菜品排版
    swpPrint.swpPrintSet3LinesText(@"商品名称", @"数量", @"价格").swpPrintSeparateLinesStyle1();
    swpPrint.swpPrintSet3LinesText(@"鱼香肉丝", @"x1", @"20");
    swpPrint.swpPrintSet3LinesText(@"松鼠桂鱼", @"x1", @"50");
    swpPrint.swpPrintSet3LinesText(@"地三鲜", @"x1", @"30");
    swpPrint.swpPrintSet3LinesText(@"番茄炒蛋", @"x1", @"15");
    
    swpPrint.swpPrintSeparateLinesStyle1();
    
    //  包装费
    swpPrint.swpPrintSet2LinesTextOffset(270, @"包装费", @"￥10");
    //  配送费
    swpPrint.swpPrintSet2LinesTextOffset(270, @"配送费", @"￥5");
    //  优惠
    swpPrint.swpPrintSet2LinesTextOffset(270, @"优惠", @"￥10");
    
    swpPrint.swpPrintSeparateLinesStyle1();
    //  订单总金额
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentRight, SwpFontSizeMin, @"原价：￥130");
    //  实付款金额
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentRight, SwpFontSizeMiddle, @"实付款：￥120");
    swpPrint.swpPrintSeparateLinesStyle1();
    
    //  用户数据排版
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentLeft, SwpFontSizeMiddle, @"备注：送到十栋与九栋之间，靠十栋那边二楼倒数第五个空调机有绳子放下来吊。如此大胆的取餐方式，也是没谁了，问题是，外卖小哥不知道能不能找到这根绳子......（这个备注是网上找的！）");
    swpPrint.swpPrintSeparateLinesStyle1();
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentLeft, SwpFontSizeMiddle, @"姓名：swp-song");
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentLeft, SwpFontSizeMiddle, @"地址：中国北京市丰台区西客站南路华源三里1号楼");
    swpPrint.swpPrintSetTextStyle(SwpTextAlignmentLeft, SwpFontSizeMiddle, @"电话：13000009999");
    swpPrint.swpPrintEndDefaultText();
    
    
    SwpBluetooth.swpBluetoothManagerChain()
    .swpBluetoothPeripheralWriteDataChain(swpPrint.swpPrinterData.copy)
    .swpBluetoothPeripheralWriteDataCompletionChain(^(SwpBluetooth *swpBluetooth, BOOL completion, CBPeripheral * _Nonnull perpheral, NSError * _Nullable error, NSString * _Nullable errorMessage){
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"「 %@ 」「 %@ 」", perpheral.name, completion ? @"写入成功" : @"写入失败"]];
    });
    
}


#pragma mark - Init UI Methods
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
