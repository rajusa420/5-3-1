//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlLiteDatabase.h"
#import "ExerciseTypesManager.h"
#import "FiveThreeOneHelper.h"
#import "WeightEntry.h"

@interface WeightDatabase : SqlLiteDatabase
- (id)init;
- (NSArray*) getWeightEntriesForDate: (int) date weekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type;
- (BOOL)saveWeightEntry: (WeightEntry*) weightEntry;
- (NSObject*)processWeightEntry: (id) statement;
@end