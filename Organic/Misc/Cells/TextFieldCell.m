//
//  TextFieldCell.m
//  Organic
//
//  Created by Mike on 1/9/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndentedCell"];
    
    if (!self) {
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(7, 7, CGRectGetWidth(self.contentView.frame) - 14, CGRectGetHeight(self.contentView.frame) - 14)];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.textField];
    
    return self;
}


@end
