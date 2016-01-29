//
//  ContactsDatabaseOption.m
//  TestFMDBDemo
//
//  Created by Mac on 16/1/20.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "ContactsDatabaseOption.h"

@implementation ContactsDatabaseOption

+ (NSMutableArray *)queryData{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    FMDatabase *db = [DatabaseUtil shareInstance];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM contacts"];
    while ([rs next]) {
        ContactModel *contact = [[ContactModel alloc]init];
        contact.contactID = [rs intForColumn:@"contact_id"];
        contact.name = [rs stringForColumn:@"contact_name"];
        contact.phone = [rs stringForColumn:@"contact_phone"];
        [array addObject:contact];
    }
    [rs close];
    [db close];
    return array;
}

+ (BOOL)insertData:(ContactModel *)contact{
    BOOL result = NO;
    FMDatabase *db = [DatabaseUtil shareInstance];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    
    if ([db tableExists:@"contacts"]) {
        result = YES;
    }else{
        //  创建contacts表，contact_id为主键（不指定值，自增）
        if ([db executeUpdate:@"CREATE TABLE contacts(contact_id INTEGER PRIMARY KEY, contact_name TEXT, contact_phone TEXT NOT NULL)"]) {
            result = YES;
        }
    }
    if ([db executeUpdate:@"INSERT INTO contacts(contact_name,contact_phone) VALUES (?,?)",contact.name,contact.phone]) {
        result = YES;
    }
    [db close];
    return result;
}

+ (BOOL)deleteData:(int)contactID {
    BOOL result = NO;
    FMDatabase *db = [DatabaseUtil shareInstance];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    if ([db executeUpdate:@"DELETE FROM contacts WHERE contacts.contact_id = (?)",contactID]) {
        result = YES;
    }
    [db close];
    return result;
}

+ (BOOL)updateData:(ContactModel *)contact {
    BOOL result = NO;
    FMDatabase *db = [DatabaseUtil shareInstance];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    if ([db executeUpdate:@"UPDATE contacts SET contact_name = (?),contact_phone = (?) WHERE contact_id = (?)",contact.name,contact.phone],@(contact.contactID)) {
       result = YES;
    }
    [db close];
    return result;
}

@end
