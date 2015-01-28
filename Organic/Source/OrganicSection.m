//
//  OrganicSection.m
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "OrganicSection.h"

@implementation OrganicSection


#pragma mark - Cells

+ (instancetype)sectionWithCells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}


#pragma mark - Header title

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - Header view

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - Footer title

+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}


#pragma mark - Footer view

+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - The whole shabang

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle headerView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    OrganicSection *section = [[self class] new];
    section.headerTitle = headerTitle;
    section.headerView = headerView;
    section.headerHeight = headerHeight;
    section.footerTitle = footerTitle;
    section.footerView = footerView;
    section.footerHeight = footerHeight;
    section.cells = [cells mutableCopy];
    return section;
}


#pragma mark - Reuse

+ (instancetype)sectionSupportingReuseWithTitle:(NSString *)title cellCount:(NSInteger)cellCount cellHeight:(CGFloat)cellHeight cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock {
    return [[[self class] alloc] initSectionSupportingReuseWithTitle:title cellCount:cellCount cellHeight:cellHeight cellForRowBlock:cellForRowBlock actionBlock:actionBlock];
}

- (instancetype)initSectionSupportingReuseWithTitle:(NSString *)title cellCount:(NSInteger)cellCount cellHeight:(CGFloat)cellHeight cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock {
    self = [[self class] sectionWithHeaderTitle:title cells:nil];
    
    _reuseEnabled = YES;
    _reusedCellCount = cellCount;
    _reusedCellHeight = cellHeight;
    _cellForRowBlock = cellForRowBlock;
    _reusedCellActionBlock = actionBlock;
    
    return self;
}


@end
