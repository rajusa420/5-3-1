//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "FiveThreeOneHelper.h"


@implementation FiveThreeOneHelper

+ (CGFloat) getPercentageForWeek: (FiveThreeOneWeek) week set: (FiveThreeOneSet) set
{
    if (week == fivesWeek)
    {
        switch (set)
        {
            case warmupOne:
                return 30;
            case warmupTwo:
                return 35;
            case warmupThree:
                return 45;
            case setOne:
                return 65;
            case setTwo:
                return 75;
            case setThree:
                return 85;
            default:
                return 0;
        }
    }
    else if (week == threesWeek)
    {
        switch (set)
        {
            case warmupOne:
                return 30;
            case warmupTwo:
                return 35;
            case warmupThree:
                return 45;
            case setOne:
                return 70;
            case setTwo:
                return 80;
            case setThree:
                return 90;
            default:
                return 0;
        }
    }
    else if (week == fiveThreeOneWeek)
    {
        switch (set)
        {
            case warmupOne:
                return 30;
            case warmupTwo:
                return 35;
            case warmupThree:
                return 45;
            case setOne:
                return 75;
            case setTwo:
                return 85;
            case setThree:
                return 95;
            default:
                return 0;
        }
    }
    else
    {
        switch (set)
        {
            case warmupOne:
                return 30;
            case warmupTwo:
                return 40;
            case warmupThree:
                return 50;
            case setOne:
                return 40;
            case setTwo:
                return 50;
            case setThree:
                return 60;
            default:
                return 0;
        }
    }
}

+ (CGFloat) getRepsForWeek: (FiveThreeOneWeek) week set: (FiveThreeOneSet) set
{
    if (week == fivesWeek)
    {
        return 5;
    }
    else if (week == threesWeek)
    {
        return 3;

    }
    else if (week == fiveThreeOneWeek)
    {
        switch (set)
        {
            case warmupOne:
            case warmupTwo:
            case warmupThree:
            case setOne:
                return 5;
            case setTwo:
                return 3;
            case setThree:
                return 1;
            default:
                return 0;
        }
    }
    else
    {
        return 5;
    }
}

+ (BOOL) isWarmupSet: (FiveThreeOneSet) set
{
    return (set == warmupOne) || (set == warmupTwo) || (set == warmupThree);
}

+ (NSString*) getFiveThreeOneWeekSectionHeaderText: (FiveThreeOneWeek) week
{
    if (week == fivesWeek)
    {
        return @"Week 1 - 3x5";
    }
    else if (week == threesWeek)
    {
        return @"Week 2 - 3x3";
    }
    else if (week == fiveThreeOneWeek)
    {
        return @"Week 3 - 5,3,1";
    }
    else
    {
        return @"Deload";
    }
}
@end