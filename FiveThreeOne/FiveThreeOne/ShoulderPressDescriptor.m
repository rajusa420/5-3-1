//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "ShoulderPressDescriptor.h"


@implementation ShoulderPressDescriptor
- (instancetype) init
{
    if (self = [super init])
    {
        exerciseType_ = ShoulderPress;
    }

    return self;
}

- (NSString*) getName
{
    return @"ShoulderPress";
}

- (NSString*) getFriendlyName
{
    return @"Shoulder press";
}
@end