//
//  UIColor+Hex.h
//  PeoplePickerDemo
//
//  Created by ZeroX on 15/8/7.
//  Copyright (c) 2015年 ZeroX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALTERNATIVE_THEME (0)

#define YellowColor [UIColor colorWithHex:0xFFD600]
#define YellowColorWithAlpha(a) [UIColor colorWithHex:0xFFD600 alpha:a]

#if ALTERNATIVE_THEME

#define MainColor [UIColor colorWithHex:0xEA423C]
#define MainColorWithAlpha(a) [UIColor colorWithHex:0xEA423C alpha:a]
#define ContentColor [UIColor colorWithHex:0xFFE8D1]
#define ContentColorWithAlpha(a) [UIColor colorWithHex:0xFFE8D1 alpha:a]

#else

#define MainColor YellowColor
#define MainColorWithAlpha(a) YellowColorWithAlpha(a)
#define ContentColor [UIColor colorWithHex:0x000000]
#define ContentColorWithAlpha(a) [UIColor colorWithHex:0x000000 alpha:a]

#endif

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (NSString *)hexFromUIColor:(UIColor *)color;

@end
