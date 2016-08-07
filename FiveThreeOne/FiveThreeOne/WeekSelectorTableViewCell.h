//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FiveThreeOneHelper.h"

@interface WeekSelectorTableViewCell : UITableViewCell
{
    __weak IBOutlet UISegmentedControl *weekSegmentControl;
    id segmentChangedTarget_;
    SEL segmentChangedAction_;
}

- (IBAction)selectedWeekChanged:(id)sender;
- (FiveThreeOneWeek)getSelectedWeek;
- (void)setSelectedWeek: (FiveThreeOneWeek) week;
- (void)setSelectedWeek: (FiveThreeOneWeek) week fireChangeNotification: (BOOL) fireChangeNotification;
- (void)setSegmentChangedTarget: (id) target handler: (SEL) handler;

@property (readonly) UISegmentedControl* weekSegmentControl;
@end