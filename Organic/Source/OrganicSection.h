//
//  OrganicSection.h
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OrganicSection : NSObject

@property (nonatomic, strong) NSMutableArray *cells;

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;


#pragma mark - Cells

+ (instancetype)sectionWithCells:(NSArray *)cells;


#pragma mark - Header title

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;


#pragma mark - Header view

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;


#pragma mark - Footer title

+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells;


#pragma mark - Footer view

+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;

@end
