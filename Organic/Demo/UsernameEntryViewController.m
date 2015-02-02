//
//  UsernameEntryViewController.m
//  Organic
//
//  Created by Mike on 1/19/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "UsernameEntryViewController.h"
#import "TextFieldCell.h"
#import "GitUserProfileViewController.h"

@interface UsernameEntryViewController () {
    TextFieldCell *_usernameCell;
}

@end

@implementation UsernameEntryViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    
    UIImageView *gitBannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, 15, 200, 40)];
    gitBannerImageView.contentMode = UIViewContentModeScaleAspectFit;
    gitBannerImageView.image = [UIImage imageNamed:@"gitBanner"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetMaxY(gitBannerImageView.frame) + 15)];
    [headerView addSubview:gitBannerImageView];
    
    _usernameCell = [TextFieldCell new];
    _usernameCell.textField.placeholder = @"GitHub User";
    
    OrganicSection *usernameSection = [OrganicSection sectionWithHeaderView:headerView headerHeight:CGRectGetHeight(headerView.frame) cells:@[_usernameCell]];
    
    __weak typeof(self) weakSelf = self;
    OrganicCell *loginButtonCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:44 actionBlock:^{
        NSString *enteredUsername = _usernameCell.textField.text;
        
        if (enteredUsername.length == 0) {
            [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Please enter a GitHub username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
            [_usernameCell.textField becomeFirstResponder];
        }
        
        else {
            [weakSelf viewProfileForUser:enteredUsername];
        }
    }];
    loginButtonCell.textLabel.text = @"View Profile For User";
    loginButtonCell.textLabel.textAlignment = NSTextAlignmentCenter;
    loginButtonCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    OrganicSection *loginButtonSection = [OrganicSection sectionWithCells:@[loginButtonCell]];
    
    self.sections = @[usernameSection, loginButtonSection];
}

- (void)viewProfileForUser:(NSString *)user {
    GitUserProfileViewController *demoVC = [[GitUserProfileViewController alloc] initWithGitUser:user];
    [self.navigationController pushViewController:demoVC animated:YES];
}

@end
