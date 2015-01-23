//
//  OrganicCell.h
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrganicCell : UITableViewCell

@property (nonatomic) CGFloat height;
@property (nonatomic, copy) dispatch_block_t actionBlock;

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock;

@end
