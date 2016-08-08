//
// Created by Raj on 8/7/16.
// Copyright (c) 2016 Raj. All rights reserved.
//

#import "BenchViewController.h"


@implementation BenchViewController
- (instancetype)initWithCoder: (NSCoder*) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        exerciseType_ = Bench;
        self.navigationItem.title = NSLocalizedString(@"Bench press", nil);
    }

    return self;
}
@end