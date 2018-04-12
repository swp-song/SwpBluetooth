
//
//  SwpBluetoothBaseViewController.m
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpBluetoothBaseViewController.h"


/* ---------------------- Tool       ---------------------- */
/* ---------------------- Tool       ---------------------- */

/* ---------------------- Model      ---------------------- */
/* ---------------------- Model      ---------------------- */

/* ---------------------- View       ---------------------- */
/* ---------------------- View       ---------------------- */

/* ---------------------- Controller ---------------------- */
/* ---------------------- Controller ---------------------- */


@interface SwpBluetoothBaseViewController ()

#pragma mark - UI   Propertys
/* ---------------------- UI   Property  ---------------------- */
@property (nonatomic, strong) UILabel *navigationBarTitleView;
/* ---------------------- UI   Property  ---------------------- */

#pragma mark - Data Propertys
/* ---------------------- Data Property  ---------------------- */
/* ---------------------- Data Property  ---------------------- */

@end

@implementation SwpBluetoothBaseViewController

#pragma mark - Lifecycle Methods
/**
 *  @author swp_song
 *
 *  @brief  viewDidLoad ( 视图载入完成, 调用 )
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseViewControllerProperty];
    
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

/**
 *  @author swp_song
 *
 *  @brief  setBaseViewControllerProperty   ( 设置 BaseViewController 自身的属性 )
 */
- (void)setBaseViewControllerProperty {
    
    self.edgesForExtendedLayout           = UIRectEdgeNone;
    self.view.backgroundColor             = [UIColor whiteColor];
    self.navigationBarTitleSize           = 15;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

/**
 *  @author swp_song
 *
 *  @brief  setBaseViewBackgroundColor: ( 设置父类背景颜色 )
 *
 *  @param  baseViewBackgroundColor baseViewBackgroundColor
 */
- (void)setBaseViewBackgroundColor:(UIColor *)baseViewBackgroundColor {
    _baseViewBackgroundColor  = baseViewBackgroundColor;
    self.view.backgroundColor = _baseViewBackgroundColor;
}

/**
 *  @author swp_song
 *
 *  @brief  setNavigationBarTitleSize:  ( 设置导航 title 字体大小 )
 *
 *  @param  navigationBarTitleSize  navigationBarTitleSize
 */
- (void)setNavigationBarTitleSize:(CGFloat)navigationBarTitleSize {
    _navigationBarTitleSize = navigationBarTitleSize;
}



#pragma mark - Set NavigationBar Title & TitleFontSize Method
/**
 *  @author swp_song
 *
 *  @brief  navigationBarTitle:textColor:titleFontSize: ( 设置导航控制器, 显示文字, 颜色, 字体小大 )
 *
 *  @param  title       title
 *
 *  @param  textColot   textColot
 *
 *  @param  fontSize    fontSize
 */
- (void)navigationBarTitle:(NSString *)title textColor:(UIColor *)textColot titleFontSize:(NSNumber *)fontSize {
    
    self.navigationBarTitleView.font      = [UIFont systemFontOfSize:fontSize == nil ? self.navigationBarTitleSize : fontSize.floatValue];
    self.navigationBarTitleView.textColor = textColot == nil ? [UIColor blackColor] : textColot;
    self.navigationBarTitleView.text      = title == nil ? @"Title Test" : title;
    self.navigationItem.titleView           = self.navigationBarTitleView;
}


#pragma mark - Init UI Methods
- (UILabel *)navigationBarTitleView {
    
    return !_navigationBarTitleView ? _navigationBarTitleView = ({
        UILabel *label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 120, 44)];
        label.textAlignment   = NSTextAlignmentCenter;
        label.opaque          = NO;
        label;
    }) : _navigationBarTitleView;
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
