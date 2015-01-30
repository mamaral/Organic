//
//  OrganicViewControllerTests.m
//  Organic
//
//  Created by Mike on 1/29/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OrganicViewController.h"

@interface OrganicViewControllerTests : XCTestCase

@end

@implementation OrganicViewControllerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEmptyTableView {
    OrganicViewController *organicVC = [OrganicViewController new];
    organicVC.sections = @[];
    
    XCTAssertNotNil(organicVC);
    XCTAssertNotNil(organicVC.sections);
    XCTAssertEqual(organicVC.sections.count, 0);
    XCTAssertEqual([organicVC.tableView numberOfSections], 0);
}

@end
