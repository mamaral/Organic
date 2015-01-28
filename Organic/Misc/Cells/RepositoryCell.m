//
//  RepositoryCell.m
//  Organic
//
//  Created by Mike on 1/18/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "RepositoryCell.h"

@implementation RepositoryCell {
    UILabel *_repoNameLabel;
    UILabel *_repoDescriptionLabel;
    UILabel *_watchersLabel;
    UILabel *_starsLabel;
    UILabel *_forksLabel;
    
    UIImageView *_watchersIcon;
    UIImageView *_starIcon;
    UIImageView *_forkIcon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    [self generateProfileCell];
    
    return self;
}

- (void)generateProfileCell {
    _repoNameLabel = [UILabel new];
    _repoNameLabel.font = [UIFont boldSystemFontOfSize:20];
    _repoNameLabel.textColor = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:196/255.0 alpha:1.0];
    [self.contentView addSubview:_repoNameLabel];
    
    _repoDescriptionLabel = [UILabel new];
    _repoDescriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _repoDescriptionLabel.font = [UIFont systemFontOfSize:13];
    _repoDescriptionLabel.numberOfLines = 3;
    [self.contentView addSubview:_repoDescriptionLabel];

    _watchersIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watcher"]];
    [self.contentView addSubview:_watchersIcon];
    
    _watchersLabel = [UILabel new];
    _watchersLabel.font = [UIFont systemFontOfSize:12];
    _watchersLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_watchersLabel];
    
    _starIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star"]];
    [self.contentView addSubview:_starIcon];
    
    _starsLabel = [UILabel new];
    _starsLabel.font = [UIFont systemFontOfSize:12];
    _starsLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_starsLabel];
    
    _forkIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fork"]];
    [self.contentView addSubview:_forkIcon];
    
    _forksLabel = [UILabel new];
    _forksLabel.font = [UIFont systemFontOfSize:12];
    _forksLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_forksLabel];
}

- (void)setRepoDictionary:(NSDictionary *)repoDictionary {
    _repoDictionary = repoDictionary;
    
    CGFloat padding = 10;
    
    _repoNameLabel.frame = CGRectMake(padding, padding, 300, 22);
    _repoNameLabel.text = _repoDictionary[@"name"];
    
    _repoDescriptionLabel.frame = CGRectMake(padding, CGRectGetMaxY(_repoNameLabel.frame), CGRectGetWidth(self.contentView.frame) - (2 * padding), 50);
    _repoDescriptionLabel.text = _repoDictionary[@"description"];
    [_repoDescriptionLabel sizeToFit];
    
    CGFloat iconSize = 14;
    CGFloat iconPadding = 4;
    CGFloat iconYOrigin = CGRectGetMaxY(_repoDescriptionLabel.frame) + iconPadding;
    
    _watchersIcon.frame = CGRectMake(padding, iconYOrigin, iconSize, iconSize);
    
    _watchersLabel.frame = CGRectMake(CGRectGetMaxX(_watchersIcon.frame) + iconPadding, iconYOrigin, 10, iconSize);
    _watchersLabel.text = [_repoDictionary[@"watchers_count"] stringValue];
    [_watchersLabel sizeToFit];
    
    _starIcon.frame = CGRectMake(CGRectGetMaxX(_watchersLabel.frame) + (4 * iconPadding), iconYOrigin, iconSize, iconSize);
    
    _starsLabel.frame = CGRectMake(CGRectGetMaxX(_starIcon.frame) + iconPadding, iconYOrigin, 10, iconSize);
    _starsLabel.text = [_repoDictionary[@"stargazers_count"] stringValue];
    [_starsLabel sizeToFit];
    
    _forkIcon.frame = CGRectMake(CGRectGetMaxX(_starsLabel.frame) + (4 * iconPadding), iconYOrigin, iconSize, iconSize);
    
    _forksLabel.frame = CGRectMake(CGRectGetMaxX(_forkIcon.frame) + iconPadding, iconYOrigin, 10, iconSize);
    _forksLabel.text = [_repoDictionary[@"forks"] stringValue];
    [_forksLabel sizeToFit];
    
    self.height = CGRectGetMaxY(_watchersIcon.frame) + padding;
}

@end
