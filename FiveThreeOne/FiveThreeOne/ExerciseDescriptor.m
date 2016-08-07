//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "ExerciseDescriptor.h"


@implementation ExerciseDescriptor

- (ExerciseType) getType
{
    return exerciseType_;
}

- (NSString*) getName
{
    return @"";
}

- (NSString*) getFriendlyName
{
    return @"";
}

- (NSString*) getDefaultsTrainingWeightKey
{
    return [[self getName] stringByAppendingString: @"TrainingWeightKey"];
}

- (NSString*) getDefaultsTrainingRepsKey
{
    return [[self getName] stringByAppendingString: @"TrainingRepsKey"];
}

@end