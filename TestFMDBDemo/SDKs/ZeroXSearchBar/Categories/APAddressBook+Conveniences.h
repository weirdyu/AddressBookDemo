////
////  APAddressBook+Conveniences.h
////  Diange
////
////  Created by ZeroX on 15/3/2.
////  Copyright (c) 2015年 ZeroX. All rights reserved.
////
//
//#import "APAddressBook.h"
//
//extern NSString * const APAddressBookAccessChangedNotification;
//
//typedef NS_OPTIONS(NSUInteger, APContactFilter) {
//    APContactFilterNone     = 0,
//    APContactFilterName     = 1 << 0,
//    APContactFilterPinyin   = 1 << 1,
//    APContactFilterPhone    = 1 << 2,
//    APContactFilterAll      = APContactFilterName | APContactFilterPinyin | APContactFilterPhone
//};
//
//@interface APAddressBook (Conveniences)
//
///**
// *  获取所有联系人
// *
// *  @param completion 完成回调
// */
//+ (void)getAllContactsWithCompletion:(void (^)(NSArray *contactSections))completion;
///**
// *  加载联系人
// *
// *  @param completion 完成回调
// *  @param silently   是否静默处理（若用户未允许获取联系人权限则不弹出提示也不进行回调）
// */
//+ (void)loadContactsWithCompletion:(void (^)(NSArray *contactSections))completion silently:(BOOL)silently;
///**
// *  查找联系人（姓名/全拼/号码）
// *
// *  @param keyword    关键字
// *  @param filterMask 查找选项
// *  @param completion 完成回调
// */
//+ (void)filterContactsWithKeyword:(NSString *)keyword
//                       filterMask:(APContactFilter)filterMask
//                       completion:(void (^)(NSArray *filteredContactSections))completion;
///**
// *  根据联系人号码获取联系人姓名
// *
// *  @param phone 联系人号码
// *
// *  @return 联系人姓名
// */
//+ (NSString *)contactNameFromPhone:(NSString *)phone;
//
//@end
