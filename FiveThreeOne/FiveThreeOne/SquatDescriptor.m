//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "SquatDescriptor.h"


@implementation SquatDescriptor
- (instancetype) init
{
    if (self = [super init])
    {
        exerciseType_ = Squat;
    }

    return self;
}

- (NSString*) getName
{
    return @"Squat";
}

- (NSString*) getFriendlyName
{
    return [self getName];
}
@end