//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "TextEntryTableViewCell.h"


@implementation TextEntryTableViewCell

- (instancetype) init
{
    if (self = [super init])
    {
        self.userInteractionEnabled = YES;
    }

    return self;
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

- (void) setTextFieldTag: (NSUInteger) tag
{
    self.textField.tag = tag;
}
@end