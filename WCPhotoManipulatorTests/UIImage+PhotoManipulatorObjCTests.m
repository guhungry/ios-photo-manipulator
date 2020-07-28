//
//  UIImage+PhotoManipulatorTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WCPhotoManipulator-Swift.h"
#import "Helpers/UIImage+Testing.h"

@interface UIImage_PhotoManipulatorObjCTests : XCTestCase

@end

@implementation UIImage_PhotoManipulatorObjCTests {
    UIImage *image;
    UIImage *overlay;
}

- (void)setUp {
}

- (void)tearDown {
    image = nil;
    overlay = nil;
}

- (void)testHasAlpha_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"overlay.png"];
    XCTAssertNotNil(image);
    XCTAssertTrue([image respondsToSelector:@selector(hasAlpha)]);
    XCTAssertTrue([image hasAlpha]);

    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    XCTAssertFalse([image hasAlpha]);
}

- (void)testCrop_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    UIColor *expectedColor = [image colorAt:CGPointMake(52, 89)];
    XCTAssertNotNil(image);
    
    image = [image crop:CGRectMake(52, 89, 65, 74)];
    UIColor *actualColor = [image colorAt:CGPointMake(0, 0)];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 65);
    XCTAssertEqual(image.size.height, 74);
    XCTAssertTrue([actualColor isEqual:expectedColor]);
}

- (void)testResize_ShouldReturnSizeCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image resize:CGSizeMake(55, 99) scale:1];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 55);
    XCTAssertEqual(image.size.height, 99);
}

- (void)testCropAndResize_ShouldReturnSizeCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    UIColor *expectedColor = [image colorAt:CGPointMake(61, 144)];
    XCTAssertNotNil(image);
    
    image = [image crop:CGRectMake(61, 144, 166, 35) targetSize:CGSizeMake(332, 70)];
    UIColor *actualColor = [image colorAt:CGPointMake(0, 0)];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 332);
    XCTAssertEqual(image.size.height, 70);
    XCTAssertTrue([actualColor isEqual:expectedColor]);
}

- (void)testDrawText_WhenNoScale_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image drawText:@"Test Text To Draw" position:CGPointMake(15, 66) color:UIColor.blueColor size:42 thickness:5];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testDrawText_WhenHasScale_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image drawText:@"Test Text To Draw" position:CGPointMake(15, 66) color:UIColor.greenColor size:42 thickness:0 scale:2];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testOverlayImage_WhenNoScale_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    overlay = [UIImage imageNamedTest:@"overlay.png"];
    XCTAssertNotNil(image);
    
    image = [image overlayImage:overlay position:CGPointMake(66, 115)];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testOverlayImage_WhenHasScale_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    overlay = [UIImage imageNamedTest:@"overlay.png"];
    XCTAssertNotNil(image);
    
    image = [image overlayImage:overlay position:CGPointMake(99, 12) scale:3];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}
@end
