//
//  RequestManager.h
//  Organic
//
//  Created by Mike on 1/18/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (id)sharedInstance;

- (void)getGitHubDetailsForUser:(NSString *)user handler:(void (^)(NSError *error, NSDictionary *user, NSArray *repos))handler;

@end
