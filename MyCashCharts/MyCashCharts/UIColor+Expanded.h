//
//  UIColor+Expanded.h
//  cashcash
//
//  Created by 陳維漢 on 2016/8/31.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expanded)

+ (UIColor *) colorWithHexString: (NSString *)stringToConvert;
+ (UIColor *) colorWithRGBHex: (uint32_t)hex;
@end
