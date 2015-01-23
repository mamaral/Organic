//
//  ProfileCell.m
//  Organic
//
//  Created by Mike on 1/9/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+WebCache.h"
#import "StringCleaner.h"

@implementation ProfileCell {
    NSDictionary *_profileDict;
}

- (instancetype)initWithProfileDict:(NSDictionary *)profileDict {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _profileDict = profileDict;
    
    [self generateProfileCell];
    
    return self;
}

- (void)generateProfileCell {
    CGFloat padding = 7;
    
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, 70, 70)];
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:_profileDict[@"avatar_url"] ?: @""] placeholderImage:[UIImage imageNamed:@"github"]];
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.borderWidth = 1.0;
    avatarImageView.layer.cornerRadius = 4;
    avatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:avatarImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(avatarImageView.frame) + padding, padding, 200, 26)];
    nameLabel.text = [StringCleaner cleanifyPotentialString:_profileDict[@"name"] withKey:@"Name"];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.contentView addSubview:nameLabel];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), 200, 18)];
    usernameLabel.text = [StringCleaner cleanifyPotentialString:_profileDict[@"login"] withKey:@"Username"];
    usernameLabel.textColor = [UIColor blackColor];
    usernameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:usernameLabel];
    
    self.height = CGRectGetMaxY(avatarImageView.frame) + padding;
}

@end
