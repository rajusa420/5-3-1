//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProjectionHelper : NSObject
{
}

+ (CGFloat)projectionForWeight: (CGFloat) weight reps: (NSUInteger) reps;
+ (CGFloat)epleyProjectedMaxForWeight: (CGFloat) weight reps: (NSUInteger) reps;
+ (CGFloat)brzyckiProjectedMaxForWeight: (CGFloat) weight reps: (NSUInteger) reps;
+ (CGFloat)getWeightForPercentage: (CGFloat) weight percentage: (CGFloat) percentage;
+ (NSUInteger) getRepsToBeatEpleyProjection: (CGFloat) projection withWeight: (CGFloat) weight;
@end