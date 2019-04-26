//
//  UIImage+PhotoManipulatorTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImage+PhotoManipulator.h"

@interface UIImage_PhotoManipulatorTests : XCTestCase

@end

@implementation UIImage_PhotoManipulatorTests {
    UIImage *image;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    image = nil;
}

- (void)testHasAlpha_ShouldReturnCorrectly {
    image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    XCTAssertTrue([image respondsToSelector:@selector(hasAlpha)]);
    XCTAssertTrue([image hasAlpha]);

    image = [UIImage imageNamed:@"background" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    XCTAssertFalse([image hasAlpha]);
}

@end
