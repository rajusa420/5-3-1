//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TextEntryTableViewCell : UITableViewCell
{
@protected
    __weak IBOutlet UITextField *textField;
}

- (NSString*) getText;
- (void) setPlaceHolderText: (NSString*) placeHolderText;
- (void) setTextFieldChangedTarget: (id) target handler: (SEL) handler;
- (void) setTextFieldTag: (NSUInteger) tag;

@property (readonly) UITextField* textField;
@end