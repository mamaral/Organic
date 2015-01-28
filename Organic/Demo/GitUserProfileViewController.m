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
        
        OrganicSection *reposSection = [OrganicSection sectionSupportingReuseWithTitle:@"Repositories" cellCount:repos.count cellHeight:110 cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
            RepositoryCell *repoCell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell"];
            
            if (!repoCell) {
                repoCell = [RepositoryCell new];
            }
            
            repoCell.repoDictionary = repos[row];
            
            return repoCell;
            
        } actionBlock:^(NSInteger row) {
            NSDictionary *repoDict = repos[row];
            NSString *message = [NSString stringWithFormat:@"You just tapped on the cell for %@", repoDict[@"name"]];
            
            [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
        
        self.sections = @[profileSection, reposSection];
    }];
}

@end
