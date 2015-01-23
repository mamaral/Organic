//
//  StatsCell.m
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "StatsCell.h"

@implementation StatsCell {
    NSNumber *_followers;
    NSNumber *_repos;
    NSNumber *_following;
}

- (instancetype)initWithFollowers:(NSNumber *)followers repos:(NSNumber *)repos following:(NSNumber *)following {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _followers = followers;
    _repos = repos;
    _following = following;
    
    [self generateStatsCell];
    
    return self;
}

- (void)generateStatsCell {
    CGFloat padding = 7;
    
    UILabel *followersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, padding, CGRectGetWidth(self.contentView.frame) / 3, 26)];
    followersCountLabel.text = [_followers stringValue];
    followersCountLabel.font = [UIFont boldSystemFontOfSize:24];
    followersCountLabel.textAlignment = NSTextAlignmentCenter;
    followersCountLabel.textColor = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:196/255.0 alpha:1.0];
    followersCountLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:followersCountLabel];
    
    UILabel *followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(followersCountLabel.frame) + 3, CGRectGetWidth(self.contentView.frame) / 3, 16)];
    followersLabel.text = @"Followers";
    followersLabel.font = [UIFont systemFontOfSize:14];
    followersLabel.textColor = [UIColor darkGrayColor];
    followersLabel.textAlignment = NSTextAlignmentCenter;
    followersLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:followersLabel];
    
    UILabel *reposCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) / 3, padding, CGRectGetWidth(self.contentView.frame) / 3, 26)];
    reposCountLabel.text = [_repos stringValue];
    reposCountLabel.font = [UIFont boldSystemFontOfSize:24];
    reposCountLabel.textAlignment = NSTextAlignmentCenter;
    reposCountLabel.textColor = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:196/255.0 alpha:1.0];
    reposCountLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:reposCountLabel];
    
    UILabel *reposLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) / 3, CGRectGetMaxY(reposCountLabel.frame) + 3, CGRectGetWidth(self.contentView.frame) / 3, 16)];
    reposLabel.text = @"Repositories";
    reposLabel.font = [UIFont systemFontOfSize:14];
    reposLabel.textColor = [UIColor darkGrayColor];
    reposLabel.textAlignment = NSTextAlignmentCenter;
    reposLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:reposLabel];
    
    UILabel *followingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) * 2 / 3, padding, CGRectGetWidth(self.contentView.frame) / 3, 26)];
    followingCountLabel.text = [_following stringValue];
    followingCountLabel.font = [UIFont boldSystemFontOfSize:24];
    followingCountLabel.textAlignment = NSTextAlignmentCenter;
    followingCountLabel.textColor = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:196/255.0 alpha:1.0];
    followingCountLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:followingCountLabel];
    
    UILabel *followingLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) * 2 / 3, CGRectGetMaxY(followingCountLabel.frame) + 3, CGRectGetWidth(self.contentView.frame) / 3, 16)];
    followingLabel.text = @"Following";
    followingLabel.font = [UIFont systemFontOfSize:14];
    followingLabel.textColor = [UIColor darkGrayColor];
    followingLabel.textAlignment = NSTextAlignmentCenter;
    followingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:followingLabel];
    
    self.height = CGRectGetMaxY(followersLabel.frame) + padding;
}

@end
