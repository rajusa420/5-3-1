//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "AppFormatters.h"


@implementation AppFormatters
static NSNumberFormatter* numberWithDecimalFormatter;
static NSNumberFormatter* numberWithoutDecimalFormatter;
static NSDateFormatter* timeFormatter;

+ (NSNumberFormatter*) numberWithDecimalFormatter
{
    if (numberWithDecimalFormatter == nil )
    {
        numberWithDecimalFormatter = [[NSNumberFormatter alloc] init];
        [numberWithDecimalFormatter setLocale: [NSLocale currentLocale]];
        [numberWithDecimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberWithDecimalFormatter setMaximumFractionDigits:1];
    }

    return numberWithDecimalFormatter;
}

+ (NSNumberFormatter*) numberWithOutDecimalFormatter
{
    if (numberWithoutDecimalFormatter == nil )
    {
        numberWithoutDecimalFormatter = [[NSNumberFormatter alloc] init];
        [numberWithoutDecimalFormatter setLocale: [NSLocale currentLocale]];
        [numberWithoutDecimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberWithoutDecimalFormatter setMaximumFractionDigits:0];
    }

    return numberWithoutDecimalFormatter;
}

+ (NSDateFormatter*) timeFormatter
{
    if (timeFormatter == nil)
    {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale: [NSLocale currentLocale]];
        [dateFormatter setDateFormat: @"HH:mm:ss"];
        return dateFormatter;
    }

    return timeFormatter;
}

@end