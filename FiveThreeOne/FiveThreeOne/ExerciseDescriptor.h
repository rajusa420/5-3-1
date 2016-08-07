//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseTypesManager.h"


@interface ExerciseDescriptor : NSObject
{
@protected
    ExerciseType exerciseType_;
}

- (ExerciseType)getType;
- (NSString*)getName;
- (NSString*)getFriendlyName;
- (NSString*)getDefaultsTrainingWeightKey;
- (NSString*)getDefaultsTrainingRepsKey;
@end