//
//  NSData+SwpPrintText.h
//  swp_song
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 - SwpTextAlignment         文字对齐方式
 - SwpTextAlignmentLeft:    文字居左显示
 - SwpTextAlignmentRight:   文字居右显示
 - SwpTextAlignmentCenter:  文字居中显示
 */
typedef NS_ENUM(NSInteger, SwpTextAlignment) {
    SwpTextAlignmentLeft    = 0x00,
    SwpTextAlignmentCenter  = 0x01,
    SwpTextAlignmentRight   = 0x02,
};



/**
 - SwpFontSize          文字字号
 - SwpFontSizeMin:      小字号
 - SwpFontSizeMiddle:   中字号 -- 暂留 ( 不同打印机打印，指令不同 )
 - SwpFontSizeMax:      大字号
 */
typedef NS_ENUM(NSInteger, SwpFontSize) {
    SwpFontSizeMin      = 0x00,
    SwpFontSizeMiddle   = 0x01,
    SwpFontSizeMax      = 0x11,
};


@interface NSData (SwpPrintText)


#pragma mark - Swp Init Print Methods
/**
 *  @author swp_song
 *
 *  @brief  swpInitPrint    ( 初始化打印 )
 */
+ (__kindof NSData * _Nonnull (^)(void))swpInitPrint;

/**
 *  @author swp_song
 *
 *  @brief  swpInitPrint_   ( 初始化打印 )
 *
 *  @return NSData
 */
+ (instancetype)swpInitPrint_;


#pragma mark - Swp Set Text Print Chinese Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextPrintChinese  ( 打印中文 )
 */
+ (__kindof NSData * _Nonnull (^)(NSString * _Nonnull))swpSetTextPrintChinese;

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextPrintChinese_: ( 打印中文 )
 *
 *  @param  string  string
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextPrintChinese_:(NSString *)string;

#pragma mark - Swp Set Text Alignment Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextAlignment ( 设置对齐方式 )
 */
+ (__kindof NSData * _Nonnull (^)(SwpTextAlignment))swpSetTextAlignment;

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextAlignment_:   ( 设置对齐方式 )
 *
 *  @param  textAlignment   textAlignment
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextAlignment_:(SwpTextAlignment)textAlignment;


#pragma mark - Swp Set Text Font Size Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextFontSize  ( 设置对齐方式 )
 */
+ (__kindof NSData * _Nonnull (^)(SwpFontSize))swpSetTextFontSize;

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextFontSize_:    ( 设置字号 )
 *
 *  @param  fontSize    fontSize
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextFontSize_:(SwpFontSize)fontSize;

#pragma mark - Swp Set Text Next Row Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextNextRow   ( 文字换行 )
 */
+ (__kindof NSData * _Nonnull (^)(void))swpSetTextNextRow;

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextNextRow_  ( 文字换行 )
 
 *  @return NSData
 */
+ (instancetype)swpSetTextNextRow_;

#pragma mark - Swp Set Text Offset Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextOffset    ( 设置文字偏移量 )
 */
+ (__kindof NSData * _Nonnull (^)(NSInteger))swpSetTextOffset;

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextOffset_   ( 设置文字偏移量 )
 *
 *  @param  offset  offset
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextOffset_:(NSInteger)offset;




@end
NS_ASSUME_NONNULL_END
