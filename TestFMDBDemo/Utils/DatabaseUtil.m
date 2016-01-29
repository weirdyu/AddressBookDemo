//
//  fmdbUtil.m
//  TestFMDBDemo
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "DatabaseUtil.h"

@implementation DatabaseUtil

+ (FMDatabase *)shareInstance {
    static FMDatabase *db = nil;
    if (db == nil) {
        db = [[FMDatabase alloc]initWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/contacts.sqlite"]];
    }
    return db;
}

@end
