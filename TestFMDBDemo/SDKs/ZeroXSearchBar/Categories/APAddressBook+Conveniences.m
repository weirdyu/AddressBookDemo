////
////  APAddressBook+Conveniences.m
////  Diange
////
////  Created by ZeroX on 15/3/2.
////  Copyright (c) 2015年 ZeroX. All rights reserved.
////
//
//#import "APAddressBook+Conveniences.h"
//#import "APContact+Conveniences.h"
//#import "UIView+Toast.h"
//
//NSString * const APAddressBookAccessChangedNotification = @"APAddressBookAccessChangedNotification";
//NSUInteger const APAddressBookMaxPhonesCountPerContact = 5;
//
//static NSArray *_contactSections;
//static APAddressBook *_addressBook;
//
//@implementation APAddressBook (Conveniences)
//
//+ (NSOperationQueue *)defaultQueue
//{
//    static NSOperationQueue *_defaultQueue = nil;
//    static dispatch_once_t defaultQueueOnceToken;
//    dispatch_once(&defaultQueueOnceToken, ^{
//        _defaultQueue = [[NSOperationQueue alloc] init];
//        _defaultQueue.maxConcurrentOperationCount = 1;
//    });
//    return _defaultQueue;
//}
//
//+ (NSOperationQueue *)filterQueue
//{
//    static NSOperationQueue *_filterQueue = nil;
//    static dispatch_once_t filterQueueOnceToken;
//    dispatch_once(&filterQueueOnceToken, ^{
//        _filterQueue = [[NSOperationQueue alloc] init];
//        _filterQueue.maxConcurrentOperationCount = 1;
//    });
//    return _filterQueue;
//}
//
//+ (void)getAllContactsWithCompletion:(void (^)(NSArray *))completion
//{
//    [self loadContactsWithCompletion:completion silently:NO];
//}
//
//+ (void)loadContactsWithCompletion:(void (^)(NSArray *))completion silently:(BOOL)silently
//{
//    if ([APAddressBook access] != APAddressBookAccessGranted && silently) return;
//    if (_contactSections && !silently)
//    {
//        if (completion) completion(_contactSections);
//    }
//    else
//    {
//        if (!silently) [[UIApplication sharedApplication].keyWindow makeToastActivity];
//        _addressBook = [[APAddressBook alloc] init];
//        _addressBook.filterBlock = ^BOOL(APContact *contact) {
//            return contact.phones.count > 0;
//        };
//        _addressBook.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
//        [_addressBook startObserveChangesWithCallback:^{
//            [self loadContactsWithCompletion:NULL silently:YES];
//        }];
//        
//        APAddressBookAccess access = [APAddressBook access];
//        [_addressBook loadContacts:^(NSArray *contacts, NSError *error) {
//            if (access == APAddressBookAccessUnknown)
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:APAddressBookAccessChangedNotification object:nil];
//            }
//            if (!error)
//            {
//                [[self defaultQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
//                    NSArray *contactSections = [self sortedContactSectionsWithContacts:contacts needSeperating:YES];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        _contactSections = contactSections;
//                        if (completion) completion(_contactSections);
//                        if (!silently) [[UIApplication sharedApplication].keyWindow hideToastActivity];
//                    });
//                }]];
//            }
//        }];
//    }
//}
//
//+ (void)filterContactsWithKeyword:(NSString *)keyword
//                       filterMask:(APContactFilter)filterMask
//                       completion:(void (^)(NSArray *))completion
//{
//    [[self filterQueue] cancelAllOperations];
//    __block NSArray *filteredContactSections = [[NSArray alloc] initWithArray:_contactSections];
//    [[self filterQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
//        if (keyword.length > 0)
//        {
//            NSMutableArray *array = [NSMutableArray array];
//            for (NSArray *contacts in _contactSections)
//            {
//                for (APContact *contact in contacts)
//                {
//                    BOOL match = (filterMask == APContactFilterNone);
//                    BOOL phoneNumAvaliable = contact.phones.count > 0;
//                    if (phoneNumAvaliable)
//                    {
//                        if (!match && (filterMask & APContactFilterName))
//                        {
//                            match |= [contact.fullName rangeOfString:keyword options:NSCaseInsensitiveSearch].length > 0;
//                        }
//                        
//                        if (!match && (filterMask & APContactFilterPinyin))
//                        {
//                            match |= [contact.pinyin rangeOfString:keyword options:NSCaseInsensitiveSearch].length > 0;
//                        }
//                        
//                        if (!match && (filterMask & APContactFilterPhone))
//                        {
//                            for (NSString *phone in contact.phones)
//                            {
//                                NSString *phoneString = [self formattedPhoneNumberWithString:phone];
//                                match |= [phoneString rangeOfString:keyword].length > 0;
//                                if (match) break;
//                            }
//                        }
//                    }
//                    
//                    if (match) [array addObject:contact];
//                }
//            }
//            filteredContactSections = [self sortedContactSectionsWithContacts:array needSeperating:NO];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (completion) completion(filteredContactSections);
//        });
//    }]];
//}
//
//+ (NSArray *)sortedContactSectionsWithContacts:(NSArray *)contacts needSeperating:(BOOL)needSeperating
//{
//    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
//    NSMutableArray *sections = [NSMutableArray array];
//    for (int i = 0; i < collation.sectionTitles.count; i++)
//    {
//        [sections addObject:[NSMutableArray array]];
//    }
//    
//    for (APContact *contact in contacts)
//    {
//        // 去除包含号码过多的单个联系人（一般由各类卫士/助手们生成）
//        if (contact.phones.count > APAddressBookMaxPhonesCountPerContact) continue;
//        
//        NSInteger section = [collation sectionForObject:contact collationStringSelector:@selector(pinyin)];
//        if (needSeperating)
//        {
//            for (NSString *phone in contact.phones)
//            {
//                APContact *sepratedContact = [contact copy];
//                sepratedContact.phones = @[[self formattedPhoneNumberWithString:phone]];
//                [sections[section] addObject:sepratedContact];
//            }
//        }
//        else
//        {
//            [sections[section] addObject:contact];
//        }
//    }
//    return [NSArray arrayWithArray:sections];
//}
//
//+ (NSString *)contactNameFromPhone:(NSString *)phone
//{
//    if (_contactSections && phone.length > 0)
//    {
//        for (int section = 0; section < _contactSections.count; section++)
//        {
//            for (int row = 0; row < [(NSArray *)_contactSections[section] count]; row++)
//            {
//                APContact *contact = _contactSections[section][row];
//                if ([phone isEqualToString:contact.phones.firstObject])
//                {
//                    return contact.fullName;
//                }
//            }
//        }
//    }
//    return phone;
//}
//
//+ (NSString *)formattedPhoneNumberWithString:(NSString *)string
//{
//    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//    string = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet] componentsJoinedByString:@""];
//    return string;
//}
//
//@end
