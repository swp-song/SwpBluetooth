//
//  SwpBluetoothNavigationController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//


/* ---------------------- Tool       ---------------------- */
#import <SwpCateGory/UIColor+SwpColor.h>                    // Color  分类
#import <SwpCateGory/UINavigationBar+SwpNavigationBar.h>    // UINavigationBar 分类
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

/* ---------------------- Controller ---------------------- */
/* ---------------------- Controller ---------------------- */


#import "SwpBluetoothNavigationController.h"

@interface SwpBluetoothNavigationController ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* ---------------------- Data Property  ---------------------- */

@end

@implementation SwpBluetoothNavigationController

#pragma mark - Lifecycle Methods
/**
 *  @author swp_song
 *
 *  @brief  viewDidLoad ( 视图载入完成, 调用 )
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 返回按钮
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // 导航 控制器 颜色
    self.navigationBar.swpNavigationBarSetBackgroundColorChain([UIColor whiteColor]);
    
    self.navigationBar.swpNavigationBarSetBottomLineViewHiddenChain(YES);
    
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

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

/**!
 *  @author swp_song
 *
 *  @brief  preferredStatusBarStyle:    ( 设置 状态栏 字体样式 )
 *
 *  @return UIStatusBarStyle
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark -
/**
 *  @author swp_song
 *
 *  @brief  swpBluetoothNavigationControllerWithRootViewController: ( 快速初始化 )
 *
 *  @param  rootViewController      rootViewController
 *
 *  @return SwpBluetoothNavigationController
 */
+ (instancetype)swpBluetoothNavigationControllerWithRootViewController:(UIViewController *)rootViewController {
    SwpBluetoothNavigationController *swpBluetoothNavigationController = [[SwpBluetoothNavigationController alloc] initWithRootViewController:rootViewController];
    return swpBluetoothNavigationController;
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
