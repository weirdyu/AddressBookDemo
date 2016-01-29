//
//  SearchBar.m
//  Diange
//
//  Created by ZeroX on 14/12/18.
//  Copyright (c) 2014年 ZeroX. All rights reserved.
//

#import "SearchBar.h"
#import "UIColor+Hex.h"
#import "TextField.h"

@interface SearchBarTextField : TextField

@end

@implementation SearchBarTextField

- (CGRect)borderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, -10, 0);
}

@end

@interface SearchBar () <TextFieldDelegate>

@end

@implementation SearchBar

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        SearchBarTextField *textField = [[SearchBarTextField alloc] initWithFrame:self.bounds];
        textField.clipsToBounds = NO;
        textField.background = [[UIImage imageNamed:@"search_underline"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2) resizingMode:UIImageResizingModeStretch];
        textField.textColor = ContentColor;
        textField.tintColor = ContentColorWithAlpha(0.5);
        textField.font = [UIFont systemFontOfSize:15];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索歌手、歌曲、主题关键词"
                                                                          attributes:@{NSForegroundColorAttributeName:ContentColorWithAlpha(0.5)}];
        textField.enablesReturnKeyAutomatically = YES;
        textField.returnKeyType = UIReturnKeySearch;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;
    }
    return self;
}

- (NSString *)text
{
    return _textField.text;
}

- (void)setText:(NSString *)text
{
    _textField.text = text;
}

- (BOOL)becomeFirstResponder
{
    return [_textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
    {
        return [_delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textField:(UITextField *)textField textDidChange:(NSString *)text
{
    if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [_delegate searchBar:self textDidChange:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
    {
        [_delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

@end
