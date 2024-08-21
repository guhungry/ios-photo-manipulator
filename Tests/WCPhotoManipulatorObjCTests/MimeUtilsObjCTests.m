//
//  MimeUtilsObjCTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
@import WCPhotoManipulator;

@interface MimeUtilsObjCTests : XCTestCase

@end

@implementation MimeUtilsObjCTests
- (void)setUp {
}

- (void)tearDown {
}

- (void)testMimeTypePNG_ShouldReturnCorrectly {
    XCTAssert([MimeUtils.PNG isEqualToString:@"image/png"]);
}

- (void)testMimeTypeJPEG_ShouldReturnCorrectly {
    XCTAssert([MimeUtils.JPEG isEqualToString:@"image/jpeg"]);
}

- (void)testToExtension_ShouldReturnCorrectly {
    XCTAssert([[MimeUtils toExtension:@"image/png"] isEqualToString:@".png"]);
    XCTAssert([[MimeUtils toExtension:@"image/jpeg"] isEqualToString:@".jpg"]);
    XCTAssert([[MimeUtils toExtension:@"invalid"] isEqualToString:@".jpg"]);
}

@end
