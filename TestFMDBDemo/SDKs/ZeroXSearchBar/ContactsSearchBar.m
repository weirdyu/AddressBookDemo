//
//  ContactsSearchBar.m
//  Diange
//
//  Created by ZeroX on 14/12/23.
//  Copyright (c) 2014年 ZeroX. All rights reserved.
//

#import "ContactsSearchBar.h"
#import "UIView+Size.h"

@interface ContactsSearchBar ()

@end

@implementation ContactsSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.textField.enablesReturnKeyAutomatically = NO;
        
        UIImageView *searchBarBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        searchBarBackground.image = [[UIImage imageNamed:@"search_bar_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,20, 0, 20) resizingMode:UIImageResizingModeStretch];
        [self insertSubview:searchBarBackground atIndex:0];
        
        self.textField.frame = CGRectMake(10, 5, self.width - 20, self.height-10);
        self.textField.background = nil;
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = [UIColor blackColor];
        self.textField.tintColor = [UIColor lightGrayColor];
        self.textField.attributedPlaceholder = nil;
        self.textField.placeholder = @"手机号/姓名";
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    }
    return self;
}

@end
