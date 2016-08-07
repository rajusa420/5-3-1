//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "WeekSelectorTableViewCell.h"
#import "FiveThreeOneHelper.h"


@implementation WeekSelectorTableViewCell

@synthesize weekSegmentControl = weekSegmentControl;

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (FiveThreeOneWeek) getSelectedWeek
{
    if (self.weekSegmentControl)
        return (FiveThreeOneWeek)self.weekSegmentControl.selectedSegmentIndex;
    return fivesWeek;
}

- (void) setSelectedWeek: (FiveThreeOneWeek) week
{
    [self setSelectedWeek: week fireChangeNotification: NO];
}

- (void) setSelectedWeek: (FiveThreeOneWeek) week fireChangeNotification: (BOOL) fireChangeNotification
{
    self.weekSegmentControl.selectedSegmentIndex = week;
    if (fireChangeNotification)
        [self.weekSegmentControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) setSegmentChangedTarget: (id) target handler: (SEL) handler
{
    segmentChangedTarget_ = target;
    segmentChangedAction_ = handler;
}
- (IBAction)selectedWeekChanged:(id)sender
{
    if (segmentChangedTarget_ && segmentChangedAction_)
        [segmentChangedTarget_ performSelector: segmentChangedAction_ withObject: self.weekSegmentControl];
}
@end