//
//  TextField.m
//  Diange
//
//  Created by ZeroX on 14/12/30.
//  Copyright (c) 2014年 ZeroX. All rights reserved.
//

#import "TextField.h"
#import "UIView+Size.h"

typedef void (^KeyboardHandler)(CGFloat, CGFloat);

@interface TextField ()

@property(nonatomic, copy) KeyboardHandler keyboardHandler;
@property(nonatomic) CGRect keyboardRect;
@property(nonatomic, copy) NSString *lastText;

@end

@implementation TextField

- (void)dealloc
{
    [super removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addTarget:self
                 action:@selector(textFieldEditingChanged:)
       forControlEvents:UIControlEventEditingChanged];
        _lastText = @"";
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    BOOL needLayoutToAdjustKeyboard = (self.top != frame.origin.y);
    [super setFrame:frame];
    if (needLayoutToAdjustKeyboard)
    {
        [self handleKeyboardRect:_keyboardRect];
    }
}

- (void)setKeyboardHandler:(KeyboardHandler)keyboardHandler
{
    _keyboardHandler = keyboardHandler;
    if (keyboardHandler)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChangeFrame:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillChangeFrameNotification
                                                      object:nil];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    _keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self handleKeyboardRect:_keyboardRect];
}

- (void)handleKeyboardRect:(CGRect)keyboardRect
{
    CGFloat bottom = [self convertPoint:CGPointMake(0, self.height + 10) toView:[UIApplication sharedApplication].keyWindow].y;
    CGFloat deltaY = MIN(0, _keyboardRect.origin.y - bottom);
    CGFloat keyboardHeight = _keyboardRect.size.height;
    if (_keyboardHandler) _keyboardHandler(deltaY, keyboardHeight);
}

- (void)textFieldEditingChanged:(UITextField *)textField
{
    if (![_lastText isEqualToString:textField.text] && [self.delegate respondsToSelector:@selector(textField:textDidChange:)])
    {
        [(id<TextFieldDelegate>)self.delegate textField:self textDidChange:textField.text];
        _lastText = textField.text;
    }
}

@end
