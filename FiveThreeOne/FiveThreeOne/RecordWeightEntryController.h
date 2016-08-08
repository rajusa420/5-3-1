//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FiveThreeOneHelper.h"
#import "ExerciseTypesManager.h"

@interface RecordWeightEntryController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
 @protected
    __weak IBOutlet UITableView* tableView_;
    FiveThreeOneWeek week_;
    ExerciseType exerciseType_;
    CGFloat weight_;
    NSUInteger reps_;
}

@property (weak) UITableView* tableView;
- (void) set: (FiveThreeOneWeek) week exerciseType: (ExerciseType) exerciseType;
@end