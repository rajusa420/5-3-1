//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    fivesWeek = 0,
    threesWeek = 1,
    fiveThreeOneWeek = 2,
    deloadWeek = 3,
    weekCount = 4
} FiveThreeOneWeek;

typedef enum
{
    warmupOne = 0,
    warmupTwo = 1,
    warmupThree = 2,
    setOne = 3,
    setTwo = 4,
    setThree = 5,
    setCount = 6
} FiveThreeOneSet;

@interface FiveThreeOneHelper : NSObject
+ (CGFloat)getPercentageForWeek: (FiveThreeOneWeek) week set: (FiveThreeOneSet) set;
+ (CGFloat)getRepsForWeek: (FiveThreeOneWeek) week set: (FiveThreeOneSet) set;
+ (BOOL) isWarmupSet: (FiveThreeOneSet) set;
+ (NSString*) getFiveThreeOneWeekSectionHeaderText: (FiveThreeOneWeek) week;
@end