//
//  OrganicSection.h
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OrganicCell;

@interface OrganicSection : NSObject

typedef UITableViewCell * (^CellCustomizationBlock)(NSInteger row, OrganicCell *recycledCell);
typedef void (^CellActionBlock)(NSInteger row);

@property (nonatomic, strong) NSMutableArray *cells;

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;

@property (nonatomic, readonly) BOOL reuseEnabled;
@property (nonatomic, readonly) NSInteger reusedCellCount;
@property (nonatomic, strong, readonly) NSString *cellReuseIdentifier;
@property (nonatomic, readonly) UITableViewCellStyle reusedCellStyle;
@property (nonatomic, readonly) CGFloat reusedCellHeight;
@property (nonatomic, copy, readonly) CellCustomizationBlock reusedCellCustomizationBlock;
@property (nonatomic, copy, readonly) CellActionBlock reusedCellActionBlock;


#pragma mark - Convenience initializers

+ (instancetype)sectionWithCells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle headerView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;


#pragma mark - Reuse

- (void)enableReuseWithCellCount:(NSInteger)cellCount reuseIdentifier:(NSString *)identifier style:(UITableViewCellStyle)style height:(CGFloat)height cellCustomizationBlock:(CellCustomizationBlock)customizationBlock actionBlock:(CellActionBlock)actionBlock;

@end
