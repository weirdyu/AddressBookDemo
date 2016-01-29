//
//  UserInfoModel.h
//  TestFMDBDemo
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface ContactModel : NSObject

@property (nonatomic, assign) int contactID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@end
