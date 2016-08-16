//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "AppModel.h"
#import "WeightDatabase.h"
#import "WeightEntry.h"
#import "DateHelper.h"
#import "CFUUIDHelper.h"
#import "AppConstants.h"


@implementation AppModel

+ (AppModel*) instance
{
    static AppModel* __strong instance = nil;
    if (instance == nil)
        instance = [[AppModel alloc] init];
    return instance;
}

-(instancetype) init
{
    if (self = [super init])
    {
        weightDatabase_ = [[WeightDatabase alloc] init];
        [self testDatabase];
    }

    return self;
}

- (BOOL) logWeightEntry: (WeightEntry*) entry
{
    [weightDatabase_ beginTransaction];

    if (![weightDatabase_ saveWeightEntry: entry])
    {
        [weightDatabase_ rollbackTransaction];
        return NO;
    }

    [weightDatabase_ commitTransaction];
    [[NSNotificationCenter defaultCenter] postNotificationName: weightProjectionLoggedNotification object: nil];
    return YES;
}

- (NSArray*) getWeightEntriesForWeekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSArray* entries = [weightDatabase_ getWeightEntriesForWeekType: weekType exerciseType: exerciseType type: type];
    return entries;
}

- (NSArray*) getRecentEntriesForWeekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSArray* entries = [weightDatabase_ getRecentEntriesForWeekType: weekType exerciseType: exerciseType type: type];
    return entries;
}

- (NSArray*) getWeightEntriesForExerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSArray* entries = [weightDatabase_ getWeightEntriesForExerciseType: exerciseType type: type];
    return entries;
}

- (void) testDatabase
{
//#ifdef TARGET_IPHONE_SIMULATOR
    //WeightEntry* entry = [[WeightEntry alloc] initWith: 0 weekType: fivesWeek exerciseType: Squat entryType: projectionType date: [DateHelper localDaySinceReferenceDate] time: [NSDate date] deleted: 0 lastupdated: [NSDate date] uniqueid: [CFUUIDHelper createCFUUID] weight: 225.5 reps: 5];
    //WeightEntry* entry1 = [[WeightEntry alloc] initWith: 0 weekType: fivesWeek exerciseType: Squat entryType: projectionType date: [DateHelper localDaySinceReferenceDate] - 1 time: [NSDate date] deleted: 0 lastupdated: [NSDate date] uniqueid: [CFUUIDHelper createCFUUID] weight: 260.5 reps: 2];
    //WeightEntry* entry2 = [[WeightEntry alloc] initWith: 0 weekType: fivesWeek exerciseType: Squat entryType: projectionType date: [DateHelper localDaySinceReferenceDate] - 1 time: [NSDate date] deleted: 0 lastupdated: [NSDate date] uniqueid: [CFUUIDHelper createCFUUID] weight: 270 reps: 2];

    //[self logWeightEntry: entry];
    //[self logWeightEntry: entry1];
    //[self logWeightEntry: entry2];

    NSArray* array = [self getWeightEntriesForWeekType: fivesWeek exerciseType: Squat type: projectionType];
    NSLog(@"Got back %ld", (unsigned long)[array count]);
//#endif
}

@end