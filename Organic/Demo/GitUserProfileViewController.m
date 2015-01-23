//
//  GitUserProfileViewController.m
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "GitUserProfileViewController.h"
#import "ProfileCell.h"
#import "RequestManager.h"
#import "RepositoryCell.h"
#import "InfoCell.h"
#import "StatsCell.h"
#import "SVProgressHUD.h"

@interface GitUserProfileViewController () {
    NSString *_gitUser;
}

@end

@implementation GitUserProfileViewController

- (instancetype)initWithGitUser:(NSString *)gitUser {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (!self) {
        return nil;
    }
    
    _gitUser = gitUser;
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SVProgressHUD show];
    
    [[RequestManager sharedInstance] getGitHubDetailsForUser:_gitUser handler:^(NSError *error, NSDictionary *user, NSArray *repos) {
        [SVProgressHUD dismiss];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return;
        }
        
        ProfileCell *profileCell = [[ProfileCell alloc] initWithProfileDict:user];
        StatsCell *statsCell = [[StatsCell alloc] initWithFollowers:user[@"followers"] repos:user[@"public_repos"] following:user[@"following"]];
        InfoCell *infoCell = [[InfoCell alloc] initWithProfileDict:user];
        
        OrganicSection *profileSection = [OrganicSection sectionWithHeaderTitle:@"Profile" cells:@[profileCell, statsCell, infoCell]];
        
        NSMutableArray *repositoryCells = [NSMutableArray array];
        
        for (NSDictionary *repoDict in repos) {
            [repositoryCells addObject:[[RepositoryCell alloc] initWithRepoDict:repoDict]];
        }
        
        OrganicSection *reposSection = [OrganicSection sectionWithHeaderTitle:@"Popular Repositories" cells:repositoryCells];
        
        self.sections = [@[profileSection, reposSection] mutableCopy];
    }];
}

@end
