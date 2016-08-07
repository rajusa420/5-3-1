//
// Created by Raj Sathi on 1/31/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "CFUUIDHelper.h"


@implementation CFUUIDHelper
{

}

+ (CFUUIDBytes) createCFUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFUUIDBytes uuidBytes = CFUUIDGetUUIDBytes(uuidRef);
    CFRelease(uuidRef);
    return uuidBytes;
}

+ (CFUUIDBytes) CFUUIDwithBytes: (const char*) bytes
{
    CFUUIDRef ref = CFUUIDCreateWithBytes(NULL, bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15]);
    CFUUIDBytes uuidBytes = CFUUIDGetUUIDBytes(ref);
    CFRelease(ref);
    return uuidBytes;
}
@end