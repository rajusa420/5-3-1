//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "LiftViewController.h"
#import "TextEntryTableViewCell.h"
#import "ProjectionHelper.h"
#import "InputValidators.h"
#import "AppFormatters.h"
#import "FiveThreeOneHelper.h"
#import "WeekSelectorTableViewCell.h"


@implementation LiftViewController

- (instancetype) init
{
    if (self = [super init])
    {
        self.navigationItem.title = NSLocalizedString(@"Lift", nil);

    }

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 3;
        case 1:
            return 3;
        case 3:
            return 7;
        case 2:
        default:
            return 9;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#define WEIGHT_TEXT_FIELD_TAG 100000
#define REPS_TEXT_FILED_TAG 100001
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 2)
        {
            if (!weightRepsCell_)
            {
                weightRepsCell_ = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"WeightRepsCell"];
                weightRepsCell_.selectionStyle = UITableViewCellSelectionStyleNone;
            }

            [self refreshWeightRepCellText];
            return weightRepsCell_;
        }
        else
        {
            NSUInteger tag;
            NSString* placeHolderText;
            if (indexPath.row == 0)
            {
                placeHolderText = NSLocalizedString(@"Weight", nil);
                tag = WEIGHT_TEXT_FIELD_TAG;
            }
            else
            {
                placeHolderText = NSLocalizedString(@"Reps", nil);
                tag = REPS_TEXT_FILED_TAG;
            }
            TextEntryTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"TextEntryCell"];
            if (!cell)
                cell = [[TextEntryTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"TextEntryCell"];
            [cell setPlaceHolderText: placeHolderText];
            [cell setTextFieldChangedTarget: self handler: @selector(textFieldDidChange:)];
            [cell setTextFieldTag: tag];
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"ProjectionCell"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ProjectionCell"];

        CGFloat projection;
        NSString* projectionString = @"projection";
        NSString* projectionName;

        if (indexPath.row == 0)
        {
            projection = [ProjectionHelper epleyProjectedMaxForWeight: weight_ reps: reps_];
            projectionName = NSLocalizedString(@"Epley", nil);
        }
        else if (indexPath.row == 1)
        {
            projection = [ProjectionHelper brzyckiProjectedMaxForWeight: weight_ reps: reps_];
            projectionName = NSLocalizedString(@"Brzycki", nil);
        }
        else
        {
            projection = [ProjectionHelper projectionForWeight: weight_ reps: reps_];
            projection = [ProjectionHelper getWeightForPercentage: projection percentage: 90];
            projectionName = NSLocalizedString(@"Training", nil);
            projectionString = NSLocalizedString(@"max", nil);
        }

        NSString* projectionText = [NSString stringWithFormat: @"%@ %@: %@", projectionName, projectionString, [[AppFormatters numberWithDecimalFormatter] stringFromNumber: @(projection)]];
        cell.textLabel.text = projectionText;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 3)
    {
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"PercentageCell"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"PercentageCell"];
        CGFloat percentage = 50 + (indexPath.row * 10.0f);
        NSString* percentText;
        CGFloat projection = [ProjectionHelper projectionForWeight: weight_ reps: reps_];
        CGFloat ninetyPercentOfProjection = [ProjectionHelper getWeightForPercentage: projection percentage: 90];

        if ([InputValidators isValidWeight: weight_] && [InputValidators isValidRepRange: reps_])
        {
            CGFloat weight = [ProjectionHelper getWeightForPercentage: ninetyPercentOfProjection percentage: percentage];
            percentText = [NSString stringWithFormat: @"%@%% of %@: %@",
                                                      [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(percentage)],
                                                      [[AppFormatters numberWithDecimalFormatter] stringFromNumber: @(ninetyPercentOfProjection)],
                                                      [[AppFormatters numberWithDecimalFormatter] stringFromNumber: @(weight)]];
        }
        else
        {
            percentText = [NSString stringWithFormat: @"%@%% of weight", [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(percentage)]];
        }

        cell.textLabel.text = percentText;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        if (indexPath.row == 0)
        {
            if (weekSelectorCell_)
                return weekSelectorCell_;

            WeekSelectorTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"FiveThreeOneWeekSelectorCell"];
            if (!cell)
            {
                cell = [[WeekSelectorTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"FiveThreeOneWeekSelectorCell"];
            }

            [cell setSegmentChangedTarget: self handler: @selector(selectedWeekChanged:)];
            weekSelectorCell_ = cell;
            return cell;
        }
        else
        {
            UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"FiveThreeOneCell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"FiveThreeOneCell"];

            FiveThreeOneWeek week = (weekSelectorCell_) ? [weekSelectorCell_ getSelectedWeek] : fivesWeek;
            CGFloat projection = [ProjectionHelper projectionForWeight: weight_ reps: reps_];
            CGFloat ninetyPercentOfProjection = [ProjectionHelper getWeightForPercentage: projection percentage: 90];
            FiveThreeOneSet set = (FiveThreeOneSet) MIN(indexPath.row - 1, setThree);
            CGFloat percentage = [FiveThreeOneHelper getPercentageForWeek: week set: set];
            CGFloat weight = ninetyPercentOfProjection * (percentage / 100.0f);
            NSString* weightString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(weight)];

            if (indexPath.row == 7 || indexPath.row == 8)
            {
                CGFloat cellProjection = indexPath.row == 7 ? ninetyPercentOfProjection : projection;
                if (ninetyPercentOfProjection > 0)
                {
                    NSUInteger repsToBeatProjectedMax = [ProjectionHelper getRepsToBeatEpleyProjection: cellProjection withWeight: weight];
                    CGFloat projectedMax = [ProjectionHelper epleyProjectedMaxForWeight: weight reps: repsToBeatProjectedMax];
                    NSString* repsString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(repsToBeatProjectedMax)];
                    NSString* projectedMaxString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(projectedMax)];
                    cell.textLabel.text = [NSString stringWithFormat: @"%@ x %@ = %@ projected max", weightString, repsString, projectedMaxString];
                }
                else
                {
                    if (indexPath.row == 7)
                        cell.textLabel.text = @"Reps to beat training max";
                    else
                        cell.textLabel.text = @"Reps to beat projected max";
                }
            }
            else
            {
                CGFloat reps = [FiveThreeOneHelper getRepsForWeek: week set: set];
                NSString* setText = [FiveThreeOneHelper isWarmupSet: set] ? @"Warmup" : @"Set";
                NSUInteger setNumber = (set % 3) + 1;
                NSString* setString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(setNumber)];
                NSString* repsString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(reps)];
                cell.textLabel.text = [NSString stringWithFormat: @"%@ %@: %@ x %@", setText, setString, weightString, repsString];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CGFloat projection = [ProjectionHelper projectionForWeight: weight_ reps: reps_];
    CGFloat ninetyPercent = [ProjectionHelper getWeightForPercentage: projection percentage: 90];

    NSString* projectionString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(ninetyPercent)];

    switch (section)
    {
        case 0:
            return @"Calculate";
        case 1:
            return @"Projections";
        case 2:
        {
            FiveThreeOneWeek week = fivesWeek;
            if (weekSelectorCell_)
                week = [weekSelectorCell_ getSelectedWeek];

            NSString* weekText =[FiveThreeOneHelper getFiveThreeOneWeekSectionHeaderText: week];
            if (projection > 0)
            {
                return [NSString stringWithFormat: @"%@ (%@)", weekText, projectionString];
            }
            return weekText;
        }
        default:
            return @"Percentages";
    }
}

-(void) textFieldDidChange: (UITextField *) textField
{
    if (textField.tag == WEIGHT_TEXT_FIELD_TAG)
    {
        CGFloat weight = [textField.text floatValue];
        if ([InputValidators isValidWeight: weight])
            weight_ = weight;
    }
    else if (textField.tag == REPS_TEXT_FILED_TAG)
    {
        NSUInteger reps = (NSUInteger)[textField.text integerValue];
        if ([InputValidators isValidRepRange: reps])
            reps_ = reps;
    }

    [self.tableView reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 2 inSection: 0]] withRowAnimation: UITableViewRowAnimationNone];
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(1, 3)] withRowAnimation: UITableViewRowAnimationNone];
}

- (void) selectedWeekChanged: (UISegmentedControl*) segmentedControl
{
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(1, 3)] withRowAnimation: UITableViewRowAnimationNone];
}

- (void) refreshWeightRepCellText
{
    NSString* weightRepText = @"";
    if ([InputValidators isValidWeight: weight_] && [InputValidators isValidRepRange: reps_])
        weightRepText = [NSString stringWithFormat: @"%@ lbs x %@ reps", [@(weight_) stringValue], [@(reps_) stringValue]];
    weightRepsCell_.textLabel.text = weightRepText;

    [ProjectionHelper projectionForWeight: weight_ reps: reps_];
}
@end