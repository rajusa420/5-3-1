//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ExerciseTypesManager.h"

@class WeekSelectorTableViewCell;
@class WeightEntry;

typedef enum
{
   calculateSection = 0,
   projectionSection = 1,
   fiveThreeOneSection = 2,
   recentLiftsSection = 3,
   percentagesSection = 4
} LiftControllerSections;

@interface LiftViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
@protected
    UITableViewCell* weightRepsCell_;
    WeekSelectorTableViewCell* weekSelectorCell_;
    CGFloat weight_;
    NSUInteger reps_;
    ExerciseType exerciseType_;
    NSArray<WeightEntry*>* recentEntries_;
}
@end