//
//  StringCleaner.m
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "StringCleaner.h"

@implementation StringCleaner

+ (NSString *)cleanifyPotentialString:(id)potentialString withKey:(NSString *)key {
    NSString *fallbackString = [NSString stringWithFormat:@"%@ Unavailable", key];
    
    if ([potentialString isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)potentialString;
        return string.length == 0 ? fallbackString : string;
    }
    
    else {
        return fallbackString;
    }
}

@end
