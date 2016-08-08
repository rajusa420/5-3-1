//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "RecordWeightEntryController.h"
#import "FiveThreeOneHelper.h"
#import "ExerciseTypesManager.h"
#import "TextEntryTableViewCell.h"
#import "AppFormatters.h"
#import "InputValidators.h"
#import "WeightEntry.h"
#import "DateHelper.h"
#import "CFUUIDHelper.h"
#import "AppModel.h"


@implementation RecordWeightEntryController
- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        self.navigationItem.title = NSLocalizedString(@"Record Projected Max", nil);
    }

    return self;
}

@synthesize tableView = tableView_;

- (void) set: (FiveThreeOneWeek) week exerciseType: (ExerciseType) exerciseType
{
    week_ = week;
    exerciseType_ = exerciseType;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#define WEIGHT_TEXT_FIELD_TAG 200000
#define REPS_TEXT_FILED_TAG 200001
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        UITableViewCell* cell = [tableView_ dequeueReusableCellWithIdentifier: @"RecordButtonCell"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"RecordButtonCell"];
        cell.textLabel.text = @"Record new projection";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
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
        TextEntryTableViewCell* cell = [tableView_ dequeueReusableCellWithIdentifier: @"TextEntryCell"];
        if (!cell)
            cell = [[TextEntryTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"TextEntryCell"];
        [cell setPlaceHolderText: placeHolderText];
        [cell.textField setText: text];
        [cell setTextFieldChangedTarget: self handler: @selector(textFieldDidChange:)];
        [cell setTextFieldTag: tag];
        return cell;
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
        NSUInteger reps = (NSUInteger) [textField.text integerValue];
        if ([InputValidators isValidRepRange: reps])
            reps_ = reps;
    }
}

- (void)tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    if (indexPath.row == 2)
    {
        if ([InputValidators isValidWeight: weight_] && [InputValidators isValidRepRange: reps_])
        {
            WeightEntry* entry = [[WeightEntry alloc] initWith: 0
                                                      weekType: week_
                                                  exerciseType: exerciseType_
                                                     entryType: projectionType
                                                          date: [DateHelper localDaySinceReferenceDate]
                                                          time: [NSDate date]
                                                       deleted: NO
                                                   lastupdated: 0
                                                      uniqueid: [CFUUIDHelper createCFUUID]
                                                        weight: weight_
                                                          reps: reps_];
            [[AppModel instance] logWeightEntry: entry];
            [self.navigationController popViewControllerAnimated: YES];
        }
        else
        {
            // TODO: Show error dialog
        }
    }
}
@end