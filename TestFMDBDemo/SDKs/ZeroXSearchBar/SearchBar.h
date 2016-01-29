//
//  SearchBar.h
//  Diange
//
//  Created by ZeroX on 14/12/18.
//  Copyright (c) 2014年 ZeroX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

@protocol SearchBarDelegate <NSObject>

@optional

- (BOOL)searchBarShouldBeginEditing:(SearchBar *)searchBar;
- (void)searchBar:(SearchBar *)searchBar textDidChange:(NSString *)text;
- (void)searchBarSearchButtonClicked:(SearchBar *)searchBar;

@end

@interface SearchBar : UIView

@property(nonatomic, readonly, weak) UITextField *textField;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, weak) id<SearchBarDelegate> delegate;

@end
