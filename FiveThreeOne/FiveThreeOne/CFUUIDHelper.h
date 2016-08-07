//
// Created by Raj Sathi on 1/31/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CFUUIDHelper : NSObject
+ (CFUUIDBytes) createCFUUID;
+ (CFUUIDBytes) CFUUIDwithBytes: (const char*) bytes;
@end