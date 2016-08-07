//
// Created by Raj on 8/6/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WeekSelectorTableViewCell;

@interface LiftViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
@protected
    UITableViewCell* weightRepsCell_;
    WeekSelectorTableViewCell* weekSelectorCell_;
    CGFloat weight_;
    NSUInteger reps_;
}
@end