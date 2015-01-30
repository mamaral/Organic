//
//  OrganicCellTests.m
//  Organic
//
//  Created by Mike on 1/29/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OrganicCell.h"

@interface OrganicCellTests : XCTestCase

@end

@implementation OrganicCellTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConvenienceInitWithActionBlock {
    XCTestExpectation *blockCalledExpectation = [self expectationWithDescription:nil];
    
    CGFloat cellHeight = 75;
    
    dispatch_block_t actionBlock = ^{
        [blockCalledExpectation fulfill];
    };
    
    OrganicCell *cell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:cellHeight actionBlock:actionBlock];
    
    XCTAssertNotNil(cell);
    XCTAssert(cell.height == cellHeight);
    XCTAssert(cell.actionBlock == actionBlock);
    
    cell.actionBlock();
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)testConvenienceInitWithoutActionBlock {
    OrganicCell *cell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:UITableViewAutomaticDimension actionBlock:nil];
    
    XCTAssertNotNil(cell);
    XCTAssertNotNil(cell.actionBlock);
}

@end
