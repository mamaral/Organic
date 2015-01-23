//
//  StringCleaner.h
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringCleaner : NSObject

+ (NSString *)cleanifyPotentialString:(id)potentialString withKey:(NSString *)key;

@end
