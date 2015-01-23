//
//  InfoCell.m
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "InfoCell.h"
#import "StringCleaner.h"

@implementation InfoCell {
    NSDictionary *_profileDict;
}

- (instancetype)initWithProfileDict:(NSDictionary *)profileDict {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _profileDict = profileDict;
    
    [self generateInfoCell];
    
    return self;
}

- (void)generateInfoCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat lineSize = 18;
    CGFloat padding = 10;
    
    UIImageView *companyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, lineSize, lineSize)];
    companyIcon.image = [UIImage imageNamed:@"company"];
    [self.contentView addSubview:companyIcon];
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(companyIcon.frame) + padding, CGRectGetMinY(companyIcon.frame), 400, CGRectGetHeight(companyIcon.frame))];
    companyLabel.text = [StringCleaner cleanifyPotentialString:_profileDict[@"company"] withKey:@"Company"];
    companyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:companyLabel];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(companyIcon.frame) + 6, lineSize, lineSize)];
    emailIcon.image = [UIImage imageNamed:@"email"];
    [self.contentView addSubview:emailIcon];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(emailIcon.frame) + padding, CGRectGetMinY(emailIcon.frame), 400, CGRectGetHeight(emailIcon.frame))];
    emailLabel.text = [StringCleaner cleanifyPotentialString:_profileDict[@"email"] withKey:@"Email"];
    emailLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:emailLabel];
    
    UIImageView *locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(emailIcon.frame) + 6, lineSize, lineSize)];
    locationIcon.image = [UIImage imageNamed:@"location"];
    [self.contentView addSubview:locationIcon];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationIcon.frame) + padding, CGRectGetMinY(locationIcon.frame), 400, CGRectGetHeight(locationIcon.frame))];
    locationLabel.text = [StringCleaner cleanifyPotentialString:_profileDict[@"location"] withKey:@"Location"];
    locationLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:locationLabel];
    
    UIImageView *joinedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(locationIcon.frame) + 6, lineSize, lineSize)];
    joinedIcon.image = [UIImage imageNamed:@"joined"];
    [self.contentView addSubview:joinedIcon];
    
    UILabel *joinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationIcon.frame) + padding, CGRectGetMinY(joinedIcon.frame), 400, CGRectGetHeight(locationIcon.frame))];
    joinedLabel.text = [self formattedTimeStringFromDateString:_profileDict[@"created_at"]];
    joinedLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:joinedLabel];
    
    self.height = CGRectGetMaxY(joinedLabel.frame) + padding;
}

- (NSString *)formattedTimeStringFromDateString:(NSString *)unformattedDateString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    
    NSDate *date = [formatter dateFromString:unformattedDateString];
    
    NSDateFormatter *correctedFormatter = [NSDateFormatter new];
    [correctedFormatter setDateFormat:@"MMMM d, yyyy"];
    
    return [NSString stringWithFormat:@"Joined on %@", [correctedFormatter stringFromDate:date]];
}



@end
