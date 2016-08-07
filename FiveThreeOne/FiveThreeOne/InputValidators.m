//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "InputValidators.h"


@implementation InputValidators

+ (BOOL) isValidWeight: (CGFloat) weight
{
    return (weight > 0 && weight < 3000);
}

+ (BOOL) isValidRepRange: (CGFloat) reps
{
    return (reps > 0 && reps < 200);
}
@end