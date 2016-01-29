//
//  TextField.h
//  Diange
//
//  Created by ZeroX on 14/12/30.
//  Copyright (c) 2014年 ZeroX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldDelegate <UITextFieldDelegate>

@optional

- (void)textField:(UITextField *)textField textDidChange:(NSString *)text;

@end

@interface TextField : UITextField

- (void)setKeyboardHandler:(void (^)(CGFloat deltaY, CGFloat keyboardHeight))keyboardHandler;

@end
