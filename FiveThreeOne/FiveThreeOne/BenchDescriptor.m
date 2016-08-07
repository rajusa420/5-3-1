//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "BenchDescriptor.h"


@implementation BenchDescriptor
- (instancetype) init
{
    if (self = [super init])
    {
        exerciseType_ = Bench;
    }

    return self;
}

- (NSString*) getName
{
    return @"BenchPress";
}

- (NSString*) getFriendlyName
{
    return @"Bench press";
}
@end