//
//  NSData+SwpPrintText.m
//  swp_song
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "NSData+SwpPrintText.h"

@implementation NSData (SwpPrintText)

#pragma mark - Swp Init Print Methods
/**
 *  @author swp_song
 *
 *  @brief  swpInitPrint    ( 初始化打印 )
 */
+ (__kindof NSData * _Nonnull (^)(void))swpInitPrint {
    
    return ^() {
        return [self.class swpInitPrint_];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpInitPrint_   ( 初始化打印 )
 *
 *  @return NSData
 */
+ (instancetype)swpInitPrint_ {
    Byte byte[] = {0x1B, 0x40};
    return [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
}


#pragma mark - Swp Set Text Print Chinese Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextPrintChinese  ( 打印中文 )
 */
+ (__kindof NSData * _Nonnull (^)(NSString * _Nonnull))swpSetTextPrintChinese {
    
    return ^(NSString *string) {
        return [self.class swpSetTextPrintChinese_:string];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextPrintChinese_:    ( 打印中文 )
 *
 *  @param  string  string
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextPrintChinese_:(NSString *)string {
    return [string dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}


#pragma mark - Swp Set Text Alignment Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextAlignment ( 设置对齐方式 )
 */
+ (__kindof NSData * _Nonnull (^)(SwpTextAlignment))swpSetTextAlignment {
    
    return ^(SwpTextAlignment textAlignment) {
        return [self.class swpSetTextAlignment_:textAlignment];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextAlignment_:   ( 设置对齐方式 )
 *
 *  @param  textAlignment   textAlignment
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextAlignment_:(SwpTextAlignment)textAlignment {
    Byte byte[] = {0x1B, 0x61, textAlignment};
    return [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
}


#pragma mark - Swp Set Text Font Size Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextFontSize  ( 设置对齐方式 )
 */
+ (__kindof NSData * _Nonnull (^)(SwpFontSize))swpSetTextFontSize {
    return ^(SwpFontSize fontSize) {
        return [self.class swpSetTextFontSize_:fontSize];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextFontSize_: ( 设置字号 )
 *
 *  @param  fontSize    fontSize
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextFontSize_:(SwpFontSize)fontSize {
    Byte byte[] = {0x1D, 0x21, fontSize};
    return [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
}

#pragma mark - Swp Set Text Next Row Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextNextRow   ( 文字换行 )
 */
+ (__kindof NSData * _Nonnull (^)(void))swpSetTextNextRow {
    
    return ^() {
        return [self.class swpSetTextNextRow_];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextNextRow_  ( 文字换行 )
 
 *  @return NSData
 */
+ (instancetype)swpSetTextNextRow_ {
    Byte byte[] = {0x0A};
    return [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
}


#pragma mark - Swp Set Text Offset Methods
/**
 *  @author swp_song
 *
 *  @brief  swpSetTextOffset    ( 设置文字偏移量 )
 */
+ (__kindof NSData * _Nonnull (^)(NSInteger))swpSetTextOffset {
    
    return ^(NSInteger offset) {
        return [self.class swpSetTextOffset_:offset];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpSetTextOffset_   ( 设置文字偏移量 )
 *
 *  @param  offset  offset
 *
 *  @return NSData
 */
+ (instancetype)swpSetTextOffset_:(NSInteger)offset {
    //  余数
    NSInteger remainder = offset % 256;
    //  模数
    NSInteger consult   = offset / 256;
    Byte byte[]         = {0x1B, 0x24, remainder, consult};
    return [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
}


@end
