//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "ShoulderPressViewController.h"


@implementation ShoulderPressViewController
- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        exerciseType_ = ShoulderPress;
        self.navigationItem.title = NSLocalizedString(@"Shoulder press", nil);
    }

    return self;
}
@end