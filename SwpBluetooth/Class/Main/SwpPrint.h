//
//  SwpPrint.h
//  swp_song
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "NSData+SwpPrintText.h"

@interface SwpPrint : NSObject

@property (nonatomic, strong, readonly) NSData *swpPrinterData;


/**
 *  @author swp_song
 *
 *  @brief  initSwpPrint    ( 快速初始化 )
 */
+ (__kindof SwpPrint * _Nonnull (^)(void))initSwpPrint;

/**
 *  @author swp_song
 *
 *  @brief  initSwpPrint_   ( 快速初始化 )
 *
 *  @return SwpPrint
 */
+ (instancetype)initSwpPrint_;

#pragma mark - Swp Print Set Text Style

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTitle ( 设置标题, 对齐方式, alignment 对齐样式, title 标题 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, NSString * _Nonnull))swpPrintSetTitle;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTitle_:text:  ( 设置标题, 对齐方式 )
 *
 *  @param  alignment   alignment
 *
 *  @param  title       title
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSetTitle_:(SwpTextAlignment)alignment title:(NSString *)title;


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetText ( 设置文本, 对齐方式, 默认字体大小 alignment 对齐样式, text 设置文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, NSString * _Nonnull))swpPrintSetText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetText_:text:  ( 设置文本, 对齐方式, 默认字体大小 )
 *
 *  @param  alignment   alignment
 *
 *  @param  text        text
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSetText_:(SwpTextAlignment)alignment text:(NSString *)text;


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTextStyle    ( 设置文本, 对齐方式, 文字大小, alignment 对齐样式, size 字体大小, text 设置文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, SwpFontSize, NSString * _Nonnull))swpPrintSetTextStyle;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTextStyle_:size:text:    ( 设置文本, 对齐方式, 文字大小 )
 *
 *  @param  alignment   alignment
 *
 *  @param  size        size
 *
 *  @param  text        text
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSetTextStyle_:(SwpTextAlignment)alignment size:(SwpFontSize)size text:(NSString *)text;

#pragma mark - Swp Print Set 2Lines Text Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesText   ( 设置两列文本显示样式, 默认偏移量 150，leftText 左侧文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))swpPrintSet2LinesText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesText_:rightText:   ( 设置两列文本显示样式, 默认偏移量 150 )
 *
 *  @param leftText     左侧文本
 *
 *  @param rightText    右侧文本
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSet2LinesText_:(NSString *)leftText rightText:(NSString *)rightText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesTextOffset ( 设置两列文本显示样式, offset 左侧文本距右侧文本偏移量 ，leftText 左侧文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSInteger, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet2LinesTextOffset;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesTextOffset_:leftText:rightText:    ( 设置两列文本显示样式 )
 *
 *  @param  offset      左侧文本距右侧文本偏移量
 *
 *  @param  leftText    左侧文本
 *
 *  @param  rightText   右侧文本
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSet2LinesTextOffset_:(NSInteger)offset leftText:(NSString *)leftText rightText:(NSString *)rightText;


#pragma mark - Swp Print Set 3Lines Title Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesTitle  ( 设置三列标题显示样式, leftText 左侧文本, middleText 中间文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet3LinesTitle;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesTitle_:middleText:rightText:   ( 设置三列标题显示样式 )
 *
 *  @param  leftText    左侧文本
 *
 *  @param  middleText  居中文本
 *
 *  @param  rightText   右侧文本
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSet3LinesTitle_:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText;


#pragma mark - Swp Print Set 3Lines Text Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesText   ( 设置三列文本显示样式, leftText 左侧文本, middleText 中间文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet3LinesText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesText_:middleText:rightText:    ( 设置三文本题显示样式 )
 *
 *  @param  leftText    左侧文本
 *
 *  @param  middleText  居中文本
 *
 *  @param  rightText   右侧文本
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSet3LinesText_:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesText_:leftText:middleText:middleOffset:rightText:rightOffset:  ( 设置三文本题显示样式 )
 *
 *  @param  leftText        左侧文本
 *
 *  @param  middleText      居中文本
 *
 *  @param  middleOffset    居中偏移量
 *
 *  @param  rightText       右侧文本
 *
 *  @param  rightOffset     右侧偏移量
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSet3LinesText_:(NSString *)leftText middleText:(NSString *)middleText middleOffset:(NSInteger)middleOffset rightText:(NSString *)rightText rightOffset:(NSInteger)rightOffset;


#pragma mark - Swp Print Separate Lines Style Methods

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle1 ( 打印分割线样式1 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintSeparateLinesStyle1;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle1_    ( 打印分割线样式1 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesStyle1_;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle2 ( 打印分割线样式2 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintSeparateLinesStyle2;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle2_    ( 打印分割线样式2 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesStyle2_;


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesCustomStyle    ( 打印分割线, 自定义样式, separateLines 分割线样式 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull))swpPrintSeparateLinesCustomStyle;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesCustomStyle_:  ( 打印分割线, 自定义样式, separateLines 分割线样式 )
 *
 *  @param  separateLines   separateLines
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesCustomStyle_:(NSString *)separateLines;

#pragma mark - Swp Print End Custom Text Methods

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndDefaultText  ( 打印结束，默认文本内容 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintEndDefaultText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndDefaultText_ ( 打印结束，默认文本内容 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintEndDefaultText_;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndCustomText   ( 打印结束, 自定义文本内容 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull))swpPrintEndCustomText;

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndCustomText_: ( 打印结束, 自定义文本内容 )
 *
 *  @param  customText  customText
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintEndCustomText_:(NSString *)customText;

@end
