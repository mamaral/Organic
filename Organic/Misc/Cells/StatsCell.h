//
//  StatsCell.h
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "OrganicCell.h"

@interface StatsCell : OrganicCell

- (instancetype)initWithFollowers:(NSNumber *)followers repos:(NSNumber *)repos following:(NSNumber *)following;

@end
