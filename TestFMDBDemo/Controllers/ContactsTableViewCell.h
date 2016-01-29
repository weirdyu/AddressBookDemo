//
//  ContactsTableViewCell.h
//  TestFMDBDemo
//
//  Created by Mac on 16/1/20.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsTableViewCell : UITableViewCell

- (void)setName:(NSString *)name;
- (void)setPhoneNumber:(NSString *)phone;

+ (float)calculateCellHeight;

@end
