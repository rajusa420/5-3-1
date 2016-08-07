//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "ExerciseTypesManager.h"
#import "ExerciseDescriptor.h"
#import "SquatDescriptor.h"
#import "BenchDescriptor.h"
#import "DeadliftDescriptor.h"
#import "ShoulderPressDescriptor.h"


@implementation ExerciseTypesManager
static ExerciseTypesManager* exerciseTypesManagerInstance;
+ (ExerciseTypesManager*) instance
{
    if (!exerciseTypesManagerInstance)
        exerciseTypesManagerInstance = [[ExerciseTypesManager alloc] init];

    return exerciseTypesManagerInstance;
}

- (instancetype) init
{
    if (self = [super init])
    {
        descriptorMap_ = [[NSMutableDictionary alloc] initWithCapacity: 4];
        descriptorMap_[@(Squat)] = [[SquatDescriptor alloc] init];
        descriptorMap_[@(Bench)] = [[BenchDescriptor alloc] init];
        descriptorMap_[@(Deadlift)] = [[DeadliftDescriptor alloc] init];
        descriptorMap_[@(ShoulderPress)] = [[ShoulderPressDescriptor alloc] init];
    }

    return self;
}

- (ExerciseDescriptor*) getDescriptorForType: (ExerciseType) type
{
    return descriptorMap_[@(type)];
}
@end