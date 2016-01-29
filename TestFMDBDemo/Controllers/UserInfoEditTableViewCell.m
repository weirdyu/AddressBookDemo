//
//  UserInfoEditTableViewCell.m
//  TestFMDBDemo
//
//  Created by weirdyu on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "UserInfoEditTableViewCell.h"

@interface UserInfoEditTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation UserInfoEditTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width/5, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        _inputTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+10, 5, [UIScreen mainScreen].bounds.size.width-_titleLabel.frame.size.width-30, 40)];
        _inputTF.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:_inputTF];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {

    _titleLabel.text = title;
}

- (void)setInputText:(NSString *)text withPlaceholder:(NSString *)placeholder{

    _inputTF.text = text;
    _inputTF.placeholder = placeholder;
}

+ (float)calculateCellHeight {
    return 50;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
