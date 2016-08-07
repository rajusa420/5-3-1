//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "DeadliftDescriptor.h"
#import "ExerciseTypesManager.h"


@implementation DeadliftDescriptor
- (instancetype) init
{
    if (self = [super init])
    {
        exerciseType_ = Deadlift;
    }

    return self;
}

- (NSString*) getName
{
    return @"Deadlift";
}

- (NSString*) getFriendlyName
{
    return [self getName];
}
@end