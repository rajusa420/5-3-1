//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "SquatViewController.h"


@implementation SquatViewController
- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        exerciseType_ = Squat;
        self.navigationItem.title = NSLocalizedString(@"Squat", nil);
    }

    return self;
}

@end