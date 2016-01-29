//
//  fmdbUtil.h
//  TestFMDBDemo
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DatabaseUtil : NSObject

/*
 *  单例模式
 */
+ (FMDatabase *)shareInstance;

@end
