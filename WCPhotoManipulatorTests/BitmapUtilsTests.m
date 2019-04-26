//
//  BitmapUtilsTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BitmapUtils.h"

@interface BitmapUtilsTests : XCTestCase

@end

@implementation BitmapUtilsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

////////////////////////////
/// ceil
///////////////////////////
- (void)testCeil_ShouldReturnValueCorrectly {
    XCTAssertEqual([BitmapUtils ceil:5 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.8 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.5 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.1 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:5 scale:2], 5);
    XCTAssertEqual([BitmapUtils ceil:4.8 scale:2], 5);
    XCTAssertEqual([BitmapUtils ceil:4.5 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils ceil:4.1 scale:2], 4.5);
}

////////////////////////////
/// floor
///////////////////////////
- (void)testFloor_ShouldReturnValueCorrectly {
    XCTAssertEqual([BitmapUtils floor:5 scale:1], 5);
    XCTAssertEqual([BitmapUtils floor:4.8 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:4.5 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:4.1 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:5 scale:2], 5);
    XCTAssertEqual([BitmapUtils floor:4.8 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils floor:4.5 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils floor:4.1 scale:2], 4);
}

////////////////////////////
/// ceilSize
///////////////////////////
- (void)testCeilSize_ShouldReturnValueCorrectly {
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(5, 6) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.8, 5.8) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.5, 5.5) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.1, 5.1) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(5, 6) scale:2], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.8, 5.8) scale:2], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.5, 5.5) scale:2], CGSizeMake(4.5, 5.5)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.1, 5.1) scale:2], CGSizeMake(4.5, 5.5)));
}

@end
