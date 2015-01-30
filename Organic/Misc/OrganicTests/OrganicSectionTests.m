//
//  OrganicSectionTests.m
//  Organic
//
//  Created by Mike on 1/29/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OrganicSection.h"
#import "OrganicViewController.h"

@interface OrganicSectionTests : XCTestCase {
    OrganicViewController *_organicViewController;
    NSArray *_testCells;
}

@end

@implementation OrganicSectionTests

- (void)setUp {
    [super setUp];
    
    _organicViewController = [OrganicViewController new];
    _testCells = @[[OrganicCell new], [OrganicCell new], [OrganicCell new], [OrganicCell new]];
}

- (void)tearDown {
    _testCells = nil;
    _organicViewController.sections = nil;
    _organicViewController = nil;
    
    [super tearDown];
}

- (void)testSectionCellReuse {
    NSArray *dataSource = @[@"Apple", @"Orange", @"Banana", @"Grape", @"Pluto"];
    CGFloat testCellHeight = 50;
    NSString *testCellReuseID = @"TestReuseID";
    
    OrganicSection *sectionWithReuse = [OrganicSection sectionSupportingReuseWithTitle:nil cellCount:dataSource.count cellHeight:testCellHeight cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellReuseID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testCellReuseID];
        }
        
        cell.textLabel.text = dataSource[row];
        
        return cell;
        
    } actionBlock:nil];
    
    _organicViewController.sections = @[sectionWithReuse];
    
    XCTAssertNotNil(sectionWithReuse);
    XCTAssertTrue(sectionWithReuse.reuseEnabled);
    XCTAssertEqual(sectionWithReuse.reusedCellHeight, testCellHeight);
    XCTAssertEqual(sectionWithReuse.reusedCellCount, dataSource.count);
    XCTAssertNotNil(sectionWithReuse.cellForRowBlock);
    XCTAssertNil(sectionWithReuse.reusedCellActionBlock);
    
    for (NSInteger rowIndex = 0; rowIndex < dataSource.count; rowIndex++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
        UITableViewCell *cell = [_organicViewController.tableView cellForRowAtIndexPath:indexPath];
        CGFloat cellHeight = [_organicViewController tableView:_organicViewController.tableView heightForRowAtIndexPath:indexPath];
        
        XCTAssert([cell.textLabel.text isEqualToString:dataSource[rowIndex]]);
        XCTAssertEqual(testCellHeight, cellHeight);
    }
}

- (void)testSectionCellReuseActionBlocks {
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    
    __block NSInteger selectionCounter = 0;
    NSInteger cellCount = 10;
    
    OrganicSection *sectionWithReuse = [OrganicSection sectionSupportingReuseWithTitle:nil cellCount:cellCount cellHeight:50 cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        return [UITableViewCell new];
    } actionBlock:^(NSInteger row) {
        selectionCounter++;
        
        if (selectionCounter == cellCount) {
            [expectation fulfill];
        }
    }];
    
    _organicViewController.sections = @[sectionWithReuse];
    
    XCTAssertNotNil(sectionWithReuse);
    
    for (NSInteger rowIndex = 0; rowIndex < cellCount; rowIndex++) {
        [_organicViewController tableView:_organicViewController.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    }
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testSectionAndCellCount {
    OrganicSection *sectionA = [OrganicSection sectionWithCells:@[[OrganicCell new], [OrganicCell new], [OrganicCell new]]];
    OrganicSection *sectionB = [OrganicSection sectionWithCells:@[[OrganicCell new]]];
    OrganicSection *sectionC = [OrganicSection sectionWithCells:@[[OrganicCell new], [OrganicCell new], [OrganicCell new], [OrganicCell new]]];
    OrganicSection *sectionD = [OrganicSection sectionWithCells:@[]];
    
    NSArray *sections = @[sectionA, sectionB, sectionC, sectionD];
    
    _organicViewController.sections = sections;
    
    XCTAssertEqual([_organicViewController.tableView numberOfSections], sections.count);
    
    for (NSInteger sectionIndex = 0; sectionIndex < sections.count; sectionIndex++) {
        OrganicSection *section = sections[sectionIndex];
        
        XCTAssertEqual(section.cells.count, [_organicViewController.tableView numberOfRowsInSection:sectionIndex]);
    }
}

- (void)testSectionWithCells {
    OrganicSection *section = [OrganicSection sectionWithCells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
}

- (void)testSectionWithTitle {
    NSString *headerTitle = @"Foo Bar";
    
    OrganicSection *section = [OrganicSection sectionWithHeaderTitle:headerTitle cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssert([section.headerTitle isEqualToString:headerTitle]);
}

- (void)testSectionWithTitleAndFooterTitle {
    NSString *headerTitle = @"Thanks Obama";
    NSString *footerTitle = @"Something About Ninjas";
    
    OrganicSection *section = [OrganicSection sectionWithHeaderTitle:headerTitle footerTitle:footerTitle cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssert([section.headerTitle isEqualToString:headerTitle]);
    XCTAssert([section.footerTitle isEqualToString:footerTitle]);
}

- (void)testSectionWithTitleAndFooterView {
    NSString *headerTitle = @"If you're reading this you have too much time on your hands.";
    UIView *footerView = [UIView new];
    CGFloat footerHeight = 30;
    
    OrganicSection *section = [OrganicSection sectionWithHeaderTitle:headerTitle footerView:footerView footerHeight:footerHeight cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssert([section.headerTitle isEqualToString:headerTitle]);
    XCTAssertEqualObjects(section.footerView, footerView);
    XCTAssertEqual(section.footerHeight, footerHeight);
}

- (void)testSectionWithHeaderView {
    UIView *headerView = [UIView new];
    CGFloat headerHeight = 20;
    
    OrganicSection *section = [OrganicSection sectionWithHeaderView:headerView headerHeight:headerHeight cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssertEqualObjects(section.headerView, headerView);
    XCTAssertEqual(section.headerHeight, headerHeight);
}

- (void)testSectionWithHeaderViewAndFooterTitle {
    UIView *headerView = [UIView new];
    CGFloat headerHeight = 20;
    NSString *footerTitle = @"This is a string. ~--~--";
    
    OrganicSection *section = [OrganicSection sectionWithHeaderView:headerView headerHeight:headerHeight footerTitle:footerTitle cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssertEqualObjects(section.headerView, headerView);
    XCTAssertEqual(section.headerHeight, headerHeight);
    XCTAssert([section.footerTitle isEqualToString:footerTitle]);
}

- (void)testSectionWithHeaderViewAndFooterView {
    UIView *headerView = [UIView new];
    CGFloat headerHeight = 50;
    UIView *footerView = [UIView new];
    CGFloat footerHeight = 60;
    
    OrganicSection *section = [OrganicSection sectionWithHeaderView:headerView headerHeight:headerHeight footerView:footerView footerHeight:footerHeight cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssertEqualObjects(section.headerView, headerView);
    XCTAssertEqual(section.headerHeight, headerHeight);
    XCTAssertEqualObjects(section.footerView, footerView);
    XCTAssertEqual(section.footerHeight, footerHeight);
}

- (void)testSectionWithFooterTitle {
    NSString *footerTitle = @"Hanging Is Murder";
    
    OrganicSection *section = [OrganicSection sectionWithFooterTitle:footerTitle cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssert([section.footerTitle isEqualToString:footerTitle]);
}

- (void)testSectionWithFooterView {
    UIView *footerView = [UIView new];
    CGFloat footerHeight = 66;
    
    OrganicSection *section = [OrganicSection sectionWithFooterView:footerView footerHeight:footerHeight cells:_testCells];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(section.cells.count, _testCells.count);
    XCTAssertEqualObjects(section.footerView, footerView);
    XCTAssertEqual(section.footerHeight, footerHeight);
}



@end
