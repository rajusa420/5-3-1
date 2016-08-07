//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "AppModel.h"
#import "WeightDatabase.h"
#import "WeightEntry.h"
#import "DateHelper.h"
#import "CFUUIDHelper.h"


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
    return YES;
}

- (NSArray*) getWeightEntriesForDate: (int) date weekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSArray* entries = [weightDatabase_ getWeightEntriesForDate: date weekType: weekType exerciseType: exerciseType type: type];
    return entries;
}

- (void) testDatabase
{
    WeightEntry* entry = [[WeightEntry alloc] initWith: 0 weekType: fivesWeek exerciseType: Squat entryType: projectionType date: [DateHelper localDaySinceReferenceDate] time: [NSDate date] deleted: 0 lastupdated: [NSDate date] uniqueid: [CFUUIDHelper createCFUUID] weight: 225.5 reps: 5];
    WeightEntry* entry1 = [[WeightEntry alloc] initWith: 0 weekType: fivesWeek exerciseType: Bench entryType: projectionType date: [DateHelper localDaySinceReferenceDate] time: [NSDate date] deleted: 0 lastupdated: [NSDate date] uniqueid: [CFUUIDHelper createCFUUID] weight: 145.5 reps: 2];
    [self logWeightEntry: entry];
    [self logWeightEntry: entry1];

    NSArray* array = [self getWeightEntriesForDate: [DateHelper localDaySinceReferenceDate] weekType: fivesWeek exerciseType: Squat type: projectionType];
    NSLog(@"Got back %ld", (unsigned long)[array count]);
}

@end