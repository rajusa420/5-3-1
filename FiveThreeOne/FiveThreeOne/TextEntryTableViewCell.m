//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "TextEntryTableViewCell.h"


@implementation TextEntryTableViewCell

- (instancetype)initWithStyle: (UITableViewCellStyle) style reuseIdentifier: (NSString*) reuseIdentifier
{
    if (self = [super initWithStyle: style reuseIdentifier: reuseIdentifier])
    {
        self.userInteractionEnabled = YES;
        [self addInputAccessoryView];
    }

    return self;
}

- (void) addInputAccessoryView
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil], [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleDone target: self action: @selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.textField.inputAccessoryView = numberToolbar;
}

@synthesize textField = textField;
- (NSString*) getText
{
    return self.textField.text;
}

- (void) setPlaceHolderText: (NSString*) placeHolderText
{
    self.textField.placeholder = placeHolderText;
}

- (void) setTextFieldChangedTarget: (id) target handler: (SEL) handler
{
    [textField addTarget: target action: handler forControlEvents:UIControlEventEditingChanged];
}

- (void) textFieldDidEndEditing:(UITextField *) editingTextField
{
    [editingTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)editingTextField
{
    [editingTextField resignFirstResponder];
    return YES;
}

- (void) setTextFieldTag: (NSUInteger) tag
{
    self.textField.tag = tag;
}

- (IBAction)didEndEditing:(id)sender
{
    [self.textField resignFirstResponder];
}

- (void) doneWithNumberPad
{
    [self.textField endEditing: YES];
}
@end