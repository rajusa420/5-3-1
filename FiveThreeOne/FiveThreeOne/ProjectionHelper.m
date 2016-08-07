//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "ProjectionHelper.h"
#import "AppFormatters.h"


@implementation ProjectionHelper

+ (CGFloat)projectionForWeight: (CGFloat) weight reps: (NSUInteger) reps
{
    if (weight <= 0 || reps <= 0)
        return 0;

    CGFloat epley = [ProjectionHelper epleyProjectedMaxForWeight: weight reps: reps];
    CGFloat brzycki = [ProjectionHelper brzyckiProjectedMaxForWeight: weight reps: reps];

    return MAX(epley, brzycki);
}

+ (CGFloat) epleyProjectedMaxForWeight: (CGFloat) weight reps: (NSUInteger) reps
{
    CGFloat projectedMax = weight * (1 + (reps / 30.0f));
    return projectedMax;
}

+ (CGFloat) brzyckiProjectedMaxForWeight: (CGFloat) weight reps: (NSUInteger) reps
{
    CGFloat projectedMax = weight * (36.0f / (37.0f - reps));
    return projectedMax;
}

+ (CGFloat) getWeightForPercentage: (CGFloat) weight percentage: (CGFloat) percentage
{
    return weight * (percentage / 100.0f);
}

+ (NSUInteger) getRepsToBeatEpleyProjection: (CGFloat) projection withWeight: (CGFloat) weight
{
    NSUInteger reps = (NSUInteger)ceilf(((projection * 30.0f) / weight) - 31);
    return reps + 1;
}
@end