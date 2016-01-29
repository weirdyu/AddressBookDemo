//
//  ContactsTableViewCell.m
//  TestFMDBDemo
//
//  Created by Mac on 16/1/20.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "ContactsTableViewCell.h"

@interface ContactsTableViewCell ()

@property (nonatomic, strong) UILabel *headpicLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation ContactsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headpicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        _headpicLabel.layer.backgroundColor = [[UIColor grayColor]CGColor];
        _headpicLabel.layer.masksToBounds = YES;
        _headpicLabel.layer.cornerRadius = 20;
        _headpicLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_headpicLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, [UIScreen mainScreen].bounds.size.width/5, 40)];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+10, 5, [UIScreen mainScreen].bounds.size.width-_nameLabel.frame.size.width-30-50, 40)];
        _phoneLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_phoneLabel];
        
    }
    return self;
}

- (void)setName:(NSString *)name {
    
    _nameLabel.text = name;
    
    NSString *string = name;
    string = [string substringToIndex:1];
    _headpicLabel.text = string;
}

- (void)setPhoneNumber:(NSString *)phone{
    
    _phoneLabel.text = phone;
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

