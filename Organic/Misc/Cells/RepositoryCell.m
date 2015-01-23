//
//  RepositoryCell.m
//  Organic
//
//  Created by Mike on 1/18/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "RepositoryCell.h"

@implementation RepositoryCell {
    NSDictionary *_repoDict;
}

- (instancetype)initWithRepoDict:(NSDictionary *)repoDict {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _repoDict = repoDict;
    
    [self generateProfileCell];
    
    return self;
}

- (void)generateProfileCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat padding = 10;
    
    UILabel *repoNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 22)];
    repoNameLabel.text = _repoDict[@"name"];
    repoNameLabel.font = [UIFont boldSystemFontOfSize:20];
    repoNameLabel.textColor = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:196/255.0 alpha:1.0];
    [self.contentView addSubview:repoNameLabel];
    
    UILabel *repoDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(repoNameLabel.frame), CGRectGetWidth(self.contentView.frame) - (2 * padding), 50)];
    repoDescriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    repoDescriptionLabel.text = _repoDict[@"description"];
    repoDescriptionLabel.font = [UIFont systemFontOfSize:13];
    repoDescriptionLabel.numberOfLines = 3;
    [repoDescriptionLabel sizeToFit];
    [self.contentView addSubview:repoDescriptionLabel];
    
    CGFloat iconSize = 14;
    CGFloat iconPadding = 4;
    CGFloat iconYOrigin = CGRectGetMaxY(repoDescriptionLabel.frame) + iconPadding;
    
    UIImageView *watchersIcon = [[UIImageView alloc] initWithFrame:CGRectMake(padding, iconYOrigin, iconSize, iconSize)];
    watchersIcon.image = [UIImage imageNamed:@"watcher"];
    [self.contentView addSubview:watchersIcon];
    
    UILabel *watchersLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(watchersIcon.frame) + iconPadding, iconYOrigin, 10, iconSize)];
    watchersLabel.text = [_repoDict[@"watchers_count"] stringValue];
    watchersLabel.font = [UIFont systemFontOfSize:12];
    watchersLabel.textColor = [UIColor darkGrayColor];
    [watchersLabel sizeToFit];
    [self.contentView addSubview:watchersLabel];
    
    UIImageView *starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(watchersLabel.frame) + (4 * iconPadding), iconYOrigin, iconSize, iconSize)];
    starIcon.image = [UIImage imageNamed:@"star"];
    [self.contentView addSubview:starIcon];
    
    UILabel *starsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starIcon.frame) + iconPadding, iconYOrigin, 10, iconSize)];
    starsLabel.text = [_repoDict[@"stargazers_count"] stringValue];
    starsLabel.font = [UIFont systemFontOfSize:12];
    starsLabel.textColor = [UIColor darkGrayColor];
    [starsLabel sizeToFit];
    [self.contentView addSubview:starsLabel];
    
    UIImageView *forkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starsLabel.frame) + (4 * iconPadding), iconYOrigin, iconSize, iconSize)];
    forkIcon.image = [UIImage imageNamed:@"fork"];
    [self.contentView addSubview:forkIcon];
    
    UILabel *forksLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(forkIcon.frame) + iconPadding, iconYOrigin, 10, iconSize)];
    forksLabel.text = [_repoDict[@"forks"] stringValue];
    forksLabel.font = [UIFont systemFontOfSize:12];
    forksLabel.textColor = [UIColor darkGrayColor];
    [forksLabel sizeToFit];
    [self.contentView addSubview:forksLabel];
    
    self.height = CGRectGetMaxY(watchersIcon.frame) + padding;
}

@end
