//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExerciseDescriptor;

typedef enum
{
    Squat = 0,
    Bench = 1,
    Deadlift = 2,
    ShoulderPress = 3
} ExerciseType;


@interface ExerciseTypesManager : NSObject
{
@protected
    NSMutableDictionary<NSNumber*, ExerciseDescriptor*>* descriptorMap_;
}

+ (ExerciseTypesManager*)instance;
- (ExerciseDescriptor*)getDescriptorForType: (ExerciseType) type;
@end