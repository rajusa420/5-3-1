//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InputValidators : NSObject
+ (BOOL)isValidWeight: (CGFloat) weight;
+ (BOOL)isValidRepRange: (CGFloat) reps;
@end