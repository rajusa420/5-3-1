//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "WeightDatabase.h"
#import "SqlLite3Statement.h"
#import "WeightEntry.h"

@implementation WeightDatabase
- (id) init
{
    if (self = [super initWithDatabaseFileName: @"WeightLog.sqlite"])
    {

    }

    return self;
}

- (WeightEntry*) getWeightEntryForDate: (int) date weekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSString* sql = @"Select rowid, weekType, exerciseType, type, date, time, deleted, lastupdated, uniqueid, weight, reps FROM WeightEntries WHERE date = ? AND weekType = ? AND exerciseType = ? AND type = ? ORDER BY date DESC, rowid DESC";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    if (![self bindInt: date forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: weekType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: exerciseType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: type forStatement: statement atIndex: colIndex++])
        return nil;

    NSArray* weightEntries = [self executeStatement: statement processorTarget: self processorSelector: @selector(processWeightEntry:)];
    [self finalizeStatement: statement];

    if ([weightEntries count] > 1)
        NSAssert(NO, @"More than one weight entry for date");

    if ([weightEntries count] == 0)
        return nil;

    return (WeightEntry*) weightEntries[0];
}

- (NSArray*) getWeightEntriesForWeekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSString* sql = @"Select rowid, weekType, exerciseType, type, date, time, deleted, lastupdated, uniqueid, weight, reps FROM WeightEntries WHERE weekType = ? AND exerciseType = ? AND type = ? ORDER BY date DESC, rowid DESC";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    if (![self bindInt: weekType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: exerciseType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: type forStatement: statement atIndex: colIndex++])
        return nil;

    NSArray* weightEntries = [self executeStatement: statement processorTarget: self processorSelector: @selector(processWeightEntry:)];
    [self finalizeStatement: statement];

    return weightEntries;
}

- (NSArray*) getWeightEntriesForExerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSString* sql = @"Select rowid, weekType, exerciseType, type, date, time, deleted, lastupdated, uniqueid, weight, reps FROM WeightEntries WHERE exerciseType = ? AND type = ? ORDER BY date DESC, rowid DESC";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    if (![self bindInt: exerciseType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: type forStatement: statement atIndex: colIndex++])
        return nil;

    NSArray* weightEntries = [self executeStatement: statement processorTarget: self processorSelector: @selector(processWeightEntry:)];
    [self finalizeStatement: statement];

    return weightEntries;
}

- (NSArray*) getRecentEntriesForWeekType: (FiveThreeOneWeek) weekType exerciseType: (ExerciseType) exerciseType type: (WeightEntryType) type
{
    NSString* sql = @"Select rowid, weekType, exerciseType, type, date, time, deleted, lastupdated, uniqueid, weight, reps FROM WeightEntries WHERE weekType = ? AND exerciseType = ? AND type = ? ORDER BY date DESC, rowid DESC LIMIT 3";
    sqlite3_stmt* statement = [self getStatement: sql];
    int colIndex = 1;
    if (![self bindInt: weekType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: exerciseType forStatement: statement atIndex: colIndex++])
        return nil;
    if (![self bindInt: type forStatement: statement atIndex: colIndex++])
        return nil;

    NSArray* weightEntries = [self executeStatement: statement processorTarget: self processorSelector: @selector(processWeightEntry:)];
    [self finalizeStatement: statement];

    return weightEntries;
}

- (BOOL) updateWeightEntry: (WeightEntry*) weightEntry
{
    NSString* sql = @"UPDATE WeightEntries SET weight = ?, reps = ?, time = ?, LastUpdated = strftime('%s','now')*1000 WHERE rowid = ?";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    [self bindDouble: weightEntry.weight forStatement: statement atIndex: colIndex++];
    [self bindInt: (int)weightEntry.reps forStatement: statement atIndex: colIndex++];
    [self bindInt64: (sqlite_int64)([weightEntry.time timeIntervalSince1970] * 1000) forStatement: statement atIndex: colIndex++];
    [self bindInt: weightEntry.id forStatement: statement atIndex: colIndex++];

    if (![self executeStatement: statement])
    {
        return NO;
    }

    [self finalizeStatement: statement];
    return YES;
}

- (BOOL) saveWeightEntry: (WeightEntry*) weightEntry
{
    WeightEntry* savedEntry = [self getWeightEntryForDate: weightEntry.date weekType: weightEntry.weekType exerciseType: weightEntry.exerciseType type: weightEntry.entryType];
    if (savedEntry)
    {
        weightEntry.uniqueId = savedEntry.uniqueId;
        weightEntry.id = savedEntry.id;
        return [self updateWeightEntry: weightEntry];
    }

    NSString* sql = @"Insert OR Replace Into WeightEntries (weekType, exerciseType, type, date, time, deleted, lastupdated, uniqueid, weight, reps) Values (?, ?, ?, ?, ?, ?,  strftime('%s','now')*1000, ?, ?, ?)";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    [self bindInt: weightEntry.weekType forStatement: statement atIndex: colIndex++];
    [self bindInt: weightEntry.exerciseType forStatement: statement atIndex: colIndex++];
    [self bindInt: weightEntry.entryType forStatement: statement atIndex: colIndex++];
    [self bindInt: weightEntry.date forStatement: statement atIndex: colIndex++];
    [self bindInt64: (sqlite_int64)([weightEntry.time timeIntervalSince1970] * 1000) forStatement: statement atIndex: colIndex++];
    [self bindInt: weightEntry.deleted ? 1 : 0 forStatement: statement atIndex: colIndex++];
    [self bindCFUUID: weightEntry.uniqueId forStatement: statement atIndex: colIndex++];
    [self bindDouble: weightEntry.weight forStatement: statement atIndex: colIndex++];
    [self bindInt: (int)weightEntry.reps forStatement: statement atIndex: colIndex++];

    if (![self executeStatement: statement])
    {
        return NO;
    }

    [self finalizeStatement: statement];
    return YES;
}

- (NSObject*) processWeightEntry: (id) statement
{
    SqlLite3Statement* statementObject = (SqlLite3Statement*) statement;
    sqlite3_stmt* sqlLiteStatement = statementObject.statement;

    int colIndex = 0 ;
    int id = sqlite3_column_int(sqlLiteStatement, colIndex++);
    FiveThreeOneWeek weekType = (FiveThreeOneWeek)sqlite3_column_int(sqlLiteStatement, colIndex++);
    ExerciseType exerciseType = (ExerciseType)sqlite3_column_int(sqlLiteStatement, colIndex++);
    WeightEntryType type = (WeightEntryType)sqlite3_column_int(sqlLiteStatement, colIndex++);
    int date = sqlite3_column_int(sqlLiteStatement, colIndex++);
    sqlite3_int64 time = sqlite3_column_int64(sqlLiteStatement, colIndex++);
    int deleted = sqlite3_column_int(sqlLiteStatement, colIndex++);
    sqlite3_int64 lastUpdated = sqlite3_column_int64(sqlLiteStatement, colIndex++);
    CFUUIDBytes uniqueid = [self convertByteBlobToCFUUID: sqlLiteStatement atColumn: colIndex++];
    CGFloat weight = (CGFloat)sqlite3_column_double(sqlLiteStatement, colIndex++);
    int reps = sqlite3_column_int(sqlLiteStatement, colIndex++);

    return [[WeightEntry alloc] initWith: id
                                weekType: weekType
                            exerciseType: exerciseType
                               entryType: type
                                    date: date
                                    time: [NSDate dateWithTimeIntervalSince1970: time / 1000]
                                 deleted: deleted
                             lastupdated: [NSDate dateWithTimeIntervalSince1970: lastUpdated / 1000]
                                uniqueid: uniqueid
                                  weight: weight
                                    reps: (NSUInteger)reps];
}
@end