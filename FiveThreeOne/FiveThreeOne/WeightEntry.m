//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "WeightEntry.h"


@implementation WeightEntry

- (id) initWith: (int) id weekType: (FiveThreeOneWeek) weekType
   exerciseType: (ExerciseType) exerciseType
      entryType: (WeightEntryType) entryType
           date: (int) date
           time: (NSDate*) time
        deleted: (int) deleted
    lastupdated: (NSDate*) lastupdated
       uniqueid: (CFUUIDBytes) uniqueid
         weight: (CGFloat) weight
           reps: (NSUInteger) reps
{
    if (self = [super init])
    {
        self.id = id;
        self.weekType = weekType;
        self.exerciseType = exerciseType;
        self.entryType = entryType;
        self.date = date;
        self.time = time;
        self.deleted = deleted == 1;
        self.lastUpdated = lastupdated;
        uniqueid_ = uniqueid;
        self.weight = weight;
        self.reps = reps;
    }

    return self;
}

@synthesize id = id_;
@synthesize weekType = weekType_;
@synthesize exerciseType = exerciseType_;
@synthesize entryType = entryType_;
@synthesize date = date_;
@synthesize time = time_;
@synthesize deleted = deleted_;
@synthesize lastUpdated = lastUpdated_;
@synthesize uniqueId = uniqueid_;
@synthesize weight = weight_;
@synthesize reps = reps_;
@end