//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FiveThreeOneHelper.h"
#import "ExerciseTypesManager.h"

typedef enum
{
    projectionType = 0,
    recordedType = 1,
    trainingType = 2
} WeightEntryType;

@interface WeightEntry : NSObject
{
@private
    int id_;
    FiveThreeOneWeek weekType_;
    ExerciseType exerciseType_;
    WeightEntryType entryType_;
    int date_;
    NSDate* time_;
    bool deleted_;
    NSDate* lastUpdated_;
    CFUUIDBytes uniqueid_;
    CGFloat weight_;
    NSUInteger reps_;
}

- (id) initWith: (int) id weekType: (FiveThreeOneWeek) weekType
   exerciseType: (ExerciseType) exerciseType
      entryType: (WeightEntryType) entryType
           date: (int) date
           time: (NSDate*) time
        deleted: (int) deleted
    lastupdated: (NSDate*) lastupdated
       uniqueid: (CFUUIDBytes) uniqueid
         weight: (CGFloat) weight
           reps: (NSUInteger) reps;

@property (nonatomic, assign) int id;
@property (nonatomic, assign) FiveThreeOneWeek weekType;
@property (nonatomic, assign) ExerciseType exerciseType;
@property (nonatomic, assign) WeightEntryType entryType;
@property (nonatomic, assign) int date;
@property (copy) NSDate* time;
@property (nonatomic, assign) bool deleted;
@property (copy) NSDate* lastUpdated;
@property (nonatomic, assign) CFUUIDBytes uniqueId;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, assign) NSUInteger reps;
@end