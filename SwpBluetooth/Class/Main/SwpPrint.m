//
//  SwpPrint.m
//  swp_song
//
//  Created by swp_song on 2018/4/12.
//  Copyright © 2018年 swp-song. All rights reserved.
//

#import "SwpPrint.h"

@interface SwpPrint ()



@property (nonatomic, strong, readonly) NSMutableData *printerData;

@end

@implementation SwpPrint

/**
 *  @author swp_song
 *
 *  @brief  init:   ( Override Init )
 *
 *  @return SwpPrint
 */
- (instancetype)init {
    
    if (self = [super init]) {
        
        _printerData = [NSData new].mutableCopy;
        //  1.初始化打印机
        [_printerData appendData:NSData.swpInitPrint()];
    }
    return self;
}


#pragma mark -
/**
 *  @author swp_song
 *
 *  @brief  initSwpPrint    ( 快速初始化 )
 */
+ (__kindof SwpPrint * _Nonnull (^)(void))initSwpPrint {
    
    return ^() {
        return [self.class initSwpPrint_];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  initSwpPrint_   ( 快速初始化 )
 *
 *  @return SwpPrint
 */
+ (instancetype)initSwpPrint_ {
    return [self new];
}


#pragma mark - Swp Print Set Text Style

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTitle ( 设置标题, 对齐方式, alignment 对齐样式, title 标题 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, NSString * _Nonnull))swpPrintSetTitle {
    return ^(SwpTextAlignment alignment, NSString *title) {
        return [self swpPrintSetTitle_:alignment title:title];
    };
}

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
- (instancetype)swpPrintSetTitle_:(SwpTextAlignment)alignment title:(NSString *)title {
    return self.swpPrintSetTextStyle(alignment, SwpFontSizeMax, title);
}


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetText ( 设置文本, 对齐方式, 默认字体大小 alignment 对齐样式, text 设置文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, NSString * _Nonnull))swpPrintSetText {
    return ^(SwpTextAlignment alignment, NSString *text) {
        return [self swpPrintSetText_:alignment text:text];
    };
}

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
- (instancetype)swpPrintSetText_:(SwpTextAlignment)alignment text:(NSString *)text {
    return self.swpPrintSetTextStyle(alignment, SwpFontSizeMin, text);
}


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSetTextStyle    ( 设置文本, 对齐方式, 文字大小, alignment 对齐样式, size 字体大小, text 设置文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(SwpTextAlignment, SwpFontSize, NSString * _Nonnull))swpPrintSetTextStyle {
    return ^(SwpTextAlignment alignment, SwpFontSize size, NSString *text) {
        return [self swpPrintSetTextStyle_:alignment size:size text:text];
    };
}

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
- (instancetype)swpPrintSetTextStyle_:(SwpTextAlignment)alignment size:(SwpFontSize)size text:(NSString *)text {
    
    if (size == SwpFontSizeMax) {
        [_printerData appendData:NSData.swpSetTextNextRow()];
    }
    
    [_printerData appendData:NSData.swpSetTextAlignment(alignment)];
    [_printerData appendData:NSData.swpSetTextFontSize(size)];
    [_printerData appendData:NSData.swpSetTextPrintChinese(text)];
    
    if (size == SwpFontSizeMax) {
        [_printerData appendData:NSData.swpSetTextNextRow()];
    }
    [_printerData appendData:NSData.swpSetTextNextRow()];
    _swpPrinterData = _printerData.copy;
    return self;
}


#pragma mark - Swp Print Set 2Lines Text Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesText   ( 设置两列文本显示样式, 默认偏移量 150，leftText 左侧文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))swpPrintSet2LinesText {
    return ^(NSString *leftText, NSString *rightText) {
        return [self swpPrintSet2LinesText_:leftText rightText:rightText];
    };
}

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
- (instancetype)swpPrintSet2LinesText_:(NSString *)leftText rightText:(NSString *)rightText {
    return [self swpPrintSet2LinesTextOffset_:150 leftText:leftText rightText:rightText];
}


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet2LinesTextOffset ( 设置两列文本显示样式, offset 左侧文本距右侧文本偏移量 ，leftText 左侧文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSInteger, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet2LinesTextOffset {
    return ^(NSInteger offset, NSString *title, NSString *appendText) {
        return [self swpPrintSet2LinesTextOffset_:offset leftText:title rightText:appendText];
    };
}

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
- (instancetype)swpPrintSet2LinesTextOffset_:(NSInteger)offset leftText:(NSString *)leftText rightText:(NSString *)rightText {
    
    [_printerData appendData:NSData.swpSetTextAlignment(SwpTextAlignmentLeft)];
    [_printerData appendData:NSData.swpSetTextFontSize(SwpFontSizeMin)];
    [_printerData appendData:NSData.swpSetTextPrintChinese(leftText)];
    [_printerData appendData:NSData.swpSetTextOffset(offset)];
    [_printerData appendData:NSData.swpSetTextPrintChinese(rightText)];
    [_printerData appendData:NSData.swpSetTextNextRow()];
    _swpPrinterData = _printerData.copy;
    return self;
}


#pragma mark - Swp Print Set 3Lines Title Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesTitle  ( 设置三列标题显示样式, leftText 左侧文本, middleText 中间文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet3LinesTitle {
    
    return ^(NSString *leftText, NSString *middleText, NSString *rightText) {
        return [self swpPrintSet3LinesTitle_:leftText middleText:middleText rightText:rightText];
    };
}


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
- (instancetype)swpPrintSet3LinesTitle_:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    return [self swpPrintSet3LinesText_:leftText middleText:middleText middleOffset:30 rightText:rightText rightOffset:20];
}


#pragma mark - Swp Print Set 3Lines Text Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSet3LinesText   ( 设置三列文本显示样式, leftText 左侧文本, middleText 中间文本， rightText 右侧文本 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))swpPrintSet3LinesText {
    return ^(NSString *leftText, NSString *middleText, NSString *rightText) {
        return [self swpPrintSet3LinesText_:leftText middleText:middleText rightText:rightText];
    };
}



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
- (instancetype)swpPrintSet3LinesText_:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    return [self swpPrintSet3LinesText_:leftText middleText:middleText middleOffset:30 rightText:rightText rightOffset:20];
}


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
- (instancetype)swpPrintSet3LinesText_:(NSString *)leftText middleText:(NSString *)middleText middleOffset:(NSInteger)middleOffset rightText:(NSString *)rightText rightOffset:(NSInteger)rightOffset {
    
    [_printerData appendData:NSData.swpSetTextAlignment(SwpTextAlignmentLeft)];
    [_printerData appendData:NSData.swpSetTextFontSize(SwpFontSizeMin)];
    
    
    //    if (leftText) [_printerData appendData:[self subText:leftText maxLength:13]];
    if (leftText) [_printerData appendData:[self stringWrap:leftText wrapLength:7]];
    
    if (middleText) {
        [_printerData appendData:NSData.swpSetTextOffset(150 + middleOffset)];
        [_printerData appendData:NSData.swpSetTextPrintChinese(middleText)];
    }
    
    if (rightText) {
        
        [_printerData appendData:NSData.swpSetTextOffset(280 + rightOffset)];
        [_printerData appendData:NSData.swpSetTextPrintChinese(rightText)];
    }
    [_printerData appendData:NSData.swpSetTextNextRow()];
    _swpPrinterData = _printerData.copy;
    return self;
}

#pragma mark - Swp Print Separate Lines Style Methods
/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle1 ( 打印分割线样式1 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintSeparateLinesStyle1 {
    return ^() {
        return [self swpPrintSeparateLinesStyle1_];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle1_    ( 打印分割线样式1 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesStyle1_ {
    return self.swpPrintSeparateLinesCustomStyle(@"- - - - - - - - - - - - - - - -");
}


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle2 ( 打印分割线样式2 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintSeparateLinesStyle2 {
    return ^() {
        return [self swpPrintSeparateLinesStyle2_];
    };
}


/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesStyle2_    ( 打印分割线样式2 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesStyle2_ {
    return self.swpPrintSeparateLinesCustomStyle(@"********************************");
}



/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesCustomStyle    ( 打印分割线, 自定义样式, separateLines 分割线样式 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull))swpPrintSeparateLinesCustomStyle {
    return ^(NSString *separateLines) {
        return [self swpPrintSeparateLinesCustomStyle_:separateLines];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpPrintSeparateLinesCustomStyle_:  ( 打印分割线, 自定义样式, separateLines 分割线样式 )
 *
 *  @param  separateLines   separateLines
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintSeparateLinesCustomStyle_:(NSString *)separateLines {
    [_printerData appendData:NSData.swpSetTextAlignment(SwpTextAlignmentCenter)];
    [_printerData appendData:NSData.swpSetTextFontSize(SwpFontSizeMin)];
    [_printerData appendData:NSData.swpSetTextPrintChinese(separateLines)];
    [_printerData appendData:NSData.swpSetTextNextRow()];
    _swpPrinterData = _printerData.copy;
    return self;
}


#pragma mark - Swp Print End Custom Text Methods

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndDefaultText  ( 打印结束，默认文本内容 )
 */
- (__kindof SwpPrint * _Nonnull (^)(void))swpPrintEndDefaultText {
    
    return ^() {
        return [self swpPrintEndDefaultText_];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndDefaultText_ ( 打印结束，默认文本内容 )
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintEndDefaultText_ {
    return self.swpPrintEndCustomText(@"谢谢惠顾, 欢迎下次光临！");
}

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndCustomText   ( 打印结束, 自定义文本内容 )
 */
- (__kindof SwpPrint * _Nonnull (^)(NSString * _Nonnull))swpPrintEndCustomText {
    
    return ^(NSString *separateLines) {
        return [self swpPrintEndCustomText_:separateLines];
    };
}

/**
 *  @author swp_song
 *
 *  @brief  swpPrintEndCustomText_: ( 打印结束, 自定义文本内容 )
 *
 *  @param  customText  customText
 *
 *  @return SwpPrint
 */
- (instancetype)swpPrintEndCustomText_:(NSString *)customText {
    
    self.swpPrintSeparateLinesStyle1();
    [_printerData appendData:NSData.swpSetTextAlignment(SwpTextAlignmentCenter)];
    [_printerData appendData:NSData.swpSetTextFontSize(SwpFontSizeMin)];
    [_printerData appendData:NSData.swpSetTextPrintChinese(customText)];
    [_printerData appendData:NSData.swpSetTextNextRow()];
    self.swpPrintSeparateLinesStyle1();
    [_printerData appendData:NSData.swpSetTextNextRow()];
    [_printerData appendData:NSData.swpSetTextNextRow()];
    _swpPrinterData = _printerData.copy;
    return self;
}



#pragma mark - Private Methods
/**
 *  @author swp_song
 *
 *  @brief  subText:maxLength:  ( 显示字符串长度, 根据长度替换成 .. )
 *
 *  @param  text    text
 *
 *  @param  length  length
 *
 *  @return NSData
 */
- (NSData *)subText:(NSString *)text maxLength:(NSInteger)length {
    
    NSStringEncoding stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = NSData.swpSetTextPrintChinese(text);
    if (data.length > length) {
        data = [data subdataWithRange:NSMakeRange(0, length)];
        text = [[NSString alloc] initWithData:data encoding:stringEncoding];
        if (!text) {
            data = [data subdataWithRange:NSMakeRange(0, length - 1)];
            text = [[NSString alloc] initWithData:data encoding:stringEncoding];
        }
        text = [text stringByAppendingString:@".."];
    }
    return NSData.swpSetTextPrintChinese(text);
}

/**
 *  @author swp_song
 *
 *  @brief  stringWrap:wrapLength:  ( 字符串换行显示 )
 *
 *  @param  text    text
 *
 *  @param  length  length
 *
 *  @return NSData
 */
- (NSData *)stringWrap:(NSString *)text wrapLength:(NSInteger)length {
    
    
    if (text.length > length) {
        NSMutableData   *data   = [NSData data].mutableCopy;
        NSMutableString *string = text.mutableCopy;
        
        if (!string.length) return NSData.swpSetTextPrintChinese(text);
        
        for(int i=0; i<string.length; i++) {
            if (!i) continue;
            if (!(i % length)) [string insertString:@"\r" atIndex:i];
        }
        
        NSArray *array = [string componentsSeparatedByString:@"\r"];
        [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [data appendData:NSData.swpSetTextPrintChinese(obj)];
            
            if (idx == array.count - 1) return;
            [data appendData:NSData.swpSetTextNextRow()];
        }];
        return data.copy;
    }
    return NSData.swpSetTextPrintChinese(text);
}




@end
