////
////  APContact+Conveniences.m
////  ContactsDemo
////
////  Created by ZeroX on 14/12/19.
////  Copyright (c) 2014年 ZeroX. All rights reserved.
////
//
//#import "APContact+Conveniences.h"
//#import <objc/runtime.h>
//#import "PinYin4Objc.h"
//
//@implementation APContact (Conveniences)
//
//- (NSString *)pinyin
//{
//    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//    return [PinyinHelper toHanyuPinyinStringWithNSString:self.fullName withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
//}
//
//- (NSString *)fullName
//{
//    BOOL chineseName = [self isChinese:self.lastName] && [self isChinese:self.firstName];
//    NSString *seprator = !chineseName && self.firstName.length > 0 && self.lastName.length > 0 ? @" " : @"";
//    NSString *fullName = chineseName ? [NSString stringWithFormat:@"%@%@", self.lastName ? : @"", self.firstName ? : @""] :
//                                        [NSString stringWithFormat:@"%@%@%@", self.firstName ? : @"", seprator, self.lastName ? : @""];
//    if (self.firstName.length == 0 && self.lastName.length == 0) fullName = self.company;
//    if (fullName.length == 0) fullName = self.phones.firstObject;
//    return fullName;
//}
//
//- (BOOL)isEqual:(id)object
//{
//    BOOL isEqual = [super isEqual:object];
//    if (isEqual) return YES;
//    if ([object isKindOfClass:[self class]])
//    {
//        APContact *contact = (APContact *)object;
//        if ([self.fullName isEqualToString:contact.fullName] &&
//            [self.phones.firstObject isEqualToString:contact.phones.firstObject])
//        {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (BOOL)isChinese:(NSString *)string
//{
//    if (string.length == 0) return YES;
//    NSString *regex = @"[\u4e00-\u9fa5]+";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [predicate evaluateWithObject:string];
//}
//
//@end
