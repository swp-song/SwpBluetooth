//
//  SwpBluetoothBaseViewController.h
//  SwpBluetoothDemo
//
//  Created by swp_song on 2018/4/11.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN
@interface SwpBluetoothBaseViewController : UIViewController

/* 设置 背景颜色                    */
@property (nonatomic, strong) UIColor *baseViewBackgroundColor;
/* navigationBarTitleSize 文字大小  */
@property (nonatomic, assign) CGFloat navigationBarTitleSize;

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
- (void)navigationBarTitle:(NSString *)title textColor:(UIColor * _Nullable)textColot titleFontSize:(NSNumber *_Nullable)fontSize;

@end
NS_ASSUME_NONNULL_END
