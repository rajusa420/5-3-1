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
#import "ExerciseDescriptor.h"
#import "RecordWeightEntryController.h"
#import "WeightEntry.h"
#import "AppModel.h"


@implementation LiftViewController

- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        self.navigationItem.title = NSLocalizedString(@"Lift", nil);
        exerciseType_ = Squat;
    }

    return self;
}

- (void)viewDidLoad
{
    [self restoreLastSavedTrainingWeightsAndReps];
    [super viewDidLoad];
}

- (void)viewWillAppear: (BOOL) animated
{
    recentEntries_ = nil;
    [super viewWillAppear: animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case calculateSection:
            return 3;
        case projectionSection:
            return 3;
        case recentLiftsSection:
            return [[self getRecentWeightEntries] count];
        case percentagesSection:
            return 7;
        case fiveThreeOneSection:
        default:
            return 10;
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
    if (indexPath.section == calculateSection)
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
            NSString* text = @"";
            if (indexPath.row == 0)
            {
                placeHolderText = NSLocalizedString(@"Weight", nil);
                tag = WEIGHT_TEXT_FIELD_TAG;
                if ([InputValidators isValidWeight: weight_])
                    text = [[AppFormatters numberWithDecimalFormatter] stringFromNumber: @(weight_)];
            }
            else
            {
                placeHolderText = NSLocalizedString(@"Reps", nil);
                tag = REPS_TEXT_FILED_TAG;
                if ([InputValidators isValidRepRange: reps_])
                    text = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(reps_)];
            }
            TextEntryTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"TextEntryCell"];
            if (!cell)
                cell = [[TextEntryTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"TextEntryCell"];
            [cell setPlaceHolderText: placeHolderText];
            [cell.textField setText: text];
            [cell setTextFieldChangedTarget: self handler: @selector(textFieldDidChange:)];
            [cell setTextFieldTag: tag];
            return cell;
        }
    }
    else if (indexPath.section == projectionSection)
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
    else if (indexPath.section == percentagesSection)
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
    else if (indexPath.section == fiveThreeOneSection)
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
            cell.accessoryType = UITableViewCellAccessoryNone;
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
            else if (indexPath.row == 9)
            {
                cell.textLabel.text = @"Record New Projected Max";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else
            {
                CGFloat reps = [FiveThreeOneHelper getRepsForWeek: week set: set];
                NSString* setText = [FiveThreeOneHelper isWarmupSet: set] ? @"Warmup" : @"Set";
                NSUInteger setNumber = (set % 3) + 1;
                NSString* setString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(setNumber)];
                NSString* repsString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(reps)];
                NSString* plusString = [FiveThreeOneHelper isPlusSet: set] ? @"+" : @"";
                cell.textLabel.text = [NSString stringWithFormat: @"%@ %@: %@ x %@%@", setText, setString, weightString, repsString, plusString];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else
    {
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"RecentWeightEntries"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"RecentWeightEntries"];

        if (indexPath.row < [[self getRecentWeightEntries] count])
        {
            WeightEntry* entry = [self getRecentWeightEntries][(NSUInteger) indexPath.row];
            NSString* weightString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(entry.weight)];
            NSString* repsString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(entry.reps)];
            CGFloat projection = [ProjectionHelper projectionForWeight: entry.weight reps: entry.reps];
            NSString* projectionString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(projection)];
            cell.textLabel.text = [NSString stringWithFormat: @"%@ x %@ = %@", weightString, repsString, projectionString];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CGFloat projection = [ProjectionHelper projectionForWeight: weight_ reps: reps_];
    CGFloat ninetyPercent = [ProjectionHelper getWeightForPercentage: projection percentage: 90];

    NSString* projectionString = [[AppFormatters numberWithOutDecimalFormatter] stringFromNumber: @(ninetyPercent)];

    switch (section)
    {
        case calculateSection:
            return @"Calculate";
        case projectionSection:
            return @"Projections";
        case fiveThreeOneSection:
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

        case recentLiftsSection:
            return @"Recent Lifts";

        case percentagesSection:
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
    [self saveCurrentTrainingWeightAndReps];
}

- (void)tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    if (indexPath.section == 2 && indexPath.row == 9)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"RecordWeightEntryController"];
        if ([controller isKindOfClass: [RecordWeightEntryController class]])
        {
            RecordWeightEntryController* recordWeightEntryController = (RecordWeightEntryController*)controller;
            [recordWeightEntryController set: [weekSelectorCell_ getSelectedWeek] exerciseType: exerciseType_];
        }
        [self.navigationController pushViewController: controller animated:YES];
    }
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

- (ExerciseType) getType
{
    return exerciseType_;
}

- (ExerciseDescriptor*) getDescriptor
{
    return [[ExerciseTypesManager instance] getDescriptorForType: [self getType]];
}

- (void) saveCurrentTrainingWeightAndReps
{
    if ([InputValidators isValidWeight: weight_] && [InputValidators isValidRepRange: reps_])
    {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: @(weight_) forKey: [[self getDescriptor] getDefaultsTrainingWeightKey]];
        [defaults setObject: @(reps_) forKey: [[self getDescriptor] getDefaultsTrainingRepsKey]];
    }
}

- (void) restoreLastSavedTrainingWeightsAndReps
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* weightNumber = [defaults objectForKey: [[self getDescriptor] getDefaultsTrainingWeightKey]];
    NSNumber* repsNumber = [defaults objectForKey: [[self getDescriptor] getDefaultsTrainingRepsKey]];

    CGFloat weight = [weightNumber floatValue];
    NSUInteger reps = (NSUInteger)[repsNumber integerValue];

    if ([InputValidators isValidWeight: weight] && [InputValidators isValidRepRange: reps])
    {
        weight_ = weight;
        reps_ = reps;
    }
}

- (NSArray<WeightEntry*>*) getRecentWeightEntries
{
    if (!recentEntries_)
    {
        recentEntries_ = [[AppModel instance] getRecentEntriesForWeekType: [weekSelectorCell_ getSelectedWeek] exerciseType: exerciseType_ type: projectionType];
    }

    return recentEntries_;
}
@end