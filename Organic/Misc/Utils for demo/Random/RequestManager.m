//
//  RequestManager.m
//  Organic
//
//  Created by Mike on 1/18/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "RequestManager.h"
#import <UIKit/UIKit.h>

@implementation RequestManager

+ (id)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

- (void)getGitHubDetailsForUser:(NSString *)user handler:(void (^)(NSError *error, NSDictionary *user, NSArray *repos))handler {
    NSString *userURL = [NSString stringWithFormat:@"https://api.github.com/users/%@", user];
    NSString *reposURL = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", user];
    [self sendRequestToURL:userURL method:@"GET" withBody:nil completionHandler:^(NSDictionary *userInfoDict, NSError *error) {
        if (error) {
            handler(error, nil, nil);
            return;
        }
        
        [self sendRequestToURL:reposURL method:@"GET" withBody:@{@"type": @"owner"} completionHandler:^(NSArray *repos, NSError *error) {
            if (error) {
                handler(error, nil, nil);
                return;
            }
            
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stargazers_count" ascending:NO];
            NSArray *sortedArray = [repos sortedArrayUsingDescriptors:@[sortDescriptor]];
            
            handler(nil, userInfoDict, sortedArray);
        }];
    }];
}

- (void)sendRequestToURL:(NSString *)URL method:(NSString *)method withBody:(NSDictionary *)body completionHandler:(void (^)(id resultObject, NSError *error))handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        BOOL isGET = [method isEqualToString:@"GET"];
        
        NSData *data = body && !isGET ? [NSJSONSerialization dataWithJSONObject:body options:0 error:nil] : nil;
        NSString *requestURL;
        NSString *paramsString;

        if (isGET && body) {
            NSMutableArray *paramsArray = [NSMutableArray array];
            NSArray *keys = [body allKeys];
            
            for (NSString *key in keys) {
                id object = body[key];
                
                [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", [self urlEncode:key], [self urlEncode:[NSString stringWithFormat:@"%@", object]]]];
            }
            
            paramsString = [paramsArray componentsJoinedByString:@"&"];
            requestURL = [URL stringByAppendingFormat:@"?%@", paramsString];
        }
        
        else {
            requestURL = URL;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
        [request setHTTPMethod:method];
        [request setValue:[NSString stringWithFormat:@"%@", @([data length])] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:method forHTTPHeaderField:@"Request-Method"];
        [request setHTTPBody:data];
        
        NSHTTPURLResponse *response = nil;
        NSError *requestError;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        if (!responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, requestError);
            });
            return;
        }
        
        id resultObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        if (response.statusCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(resultObject, nil);
            });
        }
        
        else {
            NSError *error = [NSError errorWithDomain:@"Organic" code:response.statusCode userInfo:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
            
            return;
        }
    });
}

- (NSString *)urlEncode:(NSString *)str {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}

@end
