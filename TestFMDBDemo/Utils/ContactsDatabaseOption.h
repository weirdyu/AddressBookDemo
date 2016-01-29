//
//  ContactsDatabaseOption.h
//  TestFMDBDemo
//
//  Created by Mac on 16/1/20.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseUtil.h"
#import "ContactModel.h"

@interface ContactsDatabaseOption : NSObject

+ (NSMutableArray*)queryData;

+ (BOOL)deleteData:(int)contactID;

+ (BOOL)insertData:(ContactModel *)contact;

+ (BOOL)updateData:(ContactModel *)contact;

@end