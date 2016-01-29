//
//  UIImage+Color.h
//  PeoplePickerDemo
//
//  Created by ZeroX on 15/8/7.
//  Copyright (c) 2015年 ZeroX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIColor *)averageColor;

@end
