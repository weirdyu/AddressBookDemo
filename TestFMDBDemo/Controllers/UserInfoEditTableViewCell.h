//
//  UserInfoEditTableViewCell.h
//  TestFMDBDemo
//
//  Created by weirdyu on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoEditTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *inputTF;

- (void)setTitle:(NSString *)title;
- (void)setInputText:(NSString *)text withPlaceholder:(NSString *)placeholder;

+ (float)calculateCellHeight;

@end
