//
//  UIColor+Expanded.m
//  cashcash
//
//  Created by 陳維漢 on 2016/8/31.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "UIColor+Expanded.h"

@implementation UIColor (Expanded)


+ (UIColor *) colorWithHexString: (NSString *)stringToConvert
{
    NSString *string = stringToConvert;
    if ([string hasPrefix:@"#"]){
        string = [string substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hexNum;
    if (![scanner scanHexInt: &hexNum]) {
    return nil;
    }
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *) colorWithRGBHex: (uint32_t)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end
