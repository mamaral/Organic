//
//  OrganicCell.h
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "OrganicCell.h"

@implementation OrganicCell

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock {
    OrganicCell *cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:nil];
    cell.height = height;
    cell.actionBlock = actionBlock ?: ^{};
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    self.height = UITableViewAutomaticDimension;
    self.actionBlock = ^{};
    
    return self;
}

@end
