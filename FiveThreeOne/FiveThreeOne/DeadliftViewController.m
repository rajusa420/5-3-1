//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "DeadliftViewController.h"


@implementation DeadliftViewController
- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        type_ = Deadlift;
        self.navigationItem.title = NSLocalizedString(@"Deadlift", nil);
    }

    return self;
}
@end