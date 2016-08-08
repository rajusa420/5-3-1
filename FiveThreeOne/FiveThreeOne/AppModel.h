//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FiveThreeOneHelper.h"
#import "ExerciseTypesManager.h"
#import "WeightEntry.h"

@class WeightDatabase;
@class WeightEntry;


@interface AppModel : NSObject
{
@private
    WeightDatabase* weightDatabase_;
}

+ (AppModel*)instance;
- (BOOL)logWeightEntry: (WeightEntry*) entry;
- (NSArray*)getWeightEntriesForDate: (int) date weekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type;
- (NSArray*) getRecentEntriesForWeekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type;
- (void)testDatabase;
@end