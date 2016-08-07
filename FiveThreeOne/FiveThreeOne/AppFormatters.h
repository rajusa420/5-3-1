//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFormatters : NSObject
+ (NSNumberFormatter*) numberWithDecimalFormatter;
+ (NSNumberFormatter*) numberWithOutDecimalFormatter;
+ (NSDateFormatter*) timeFormatter;
@end