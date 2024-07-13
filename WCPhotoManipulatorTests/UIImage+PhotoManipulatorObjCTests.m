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

    TextStyle *style = [[TextStyle alloc] initWithColor:UIColor.blueColor size:42 thickness:5 rotation:0];
    image = [image drawText:@"Test Text To Draw" position:CGPointMake(15, 66) style:style];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testDrawText_WhenHasScale_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);

    TextStyle *style = [[TextStyle alloc] initWithColor:UIColor.greenColor size:42 thickness:0 rotation:0];
    image = [image drawText:@"Test Text To Draw" position:CGPointMake(15, 66) style:style scale:2];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testDrawText_WhenHasRotation_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    TextStyle *style = [[TextStyle alloc] initWithColor:UIColor.greenColor size:42 thickness:0 rotation:20];
    image = [image drawText:@"Test Rotation Text To Draw" position:CGPointMake(15, 66) style:style scale:2];
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

- (void)testFlip_WhenHasHorizontal_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image flip:FlipModeHorizontal];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testFlip_WhenHasVertical_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image flip:FlipModeVertical];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testFlip_WhenHasBoth_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    UIImage *image1 = [image flip:FlipModeVertical];
    UIImage *image2 = [image1 flip:FlipModeHorizontal];
    UIImage *image3 = [image2 flip:FlipModeVertical];
    UIImage *image4 = [image3 flip:FlipModeHorizontal];
    XCTAssertNotNil(image4);
    XCTAssertEqual(image4.size.width, 800);
    XCTAssertEqual(image4.size.height, 530);
}

- (void)testRotate_WhenR90_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image rotate:RotationModeR90];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 530);
    XCTAssertEqual(image.size.height, 800);
}

- (void)testRotate_WhenR180_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image rotate:RotationModeR180];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}

- (void)testRotate_WhenR270_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image rotate:RotationModeR270];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 530);
    XCTAssertEqual(image.size.height, 800);
}

- (void)testRotate_WhenNone_ShouldReturnCorrectly {
    image = [UIImage imageNamedTest:@"background.jpg"];
    XCTAssertNotNil(image);
    
    image = [image rotate:RotationModeNone];
    XCTAssertNotNil(image);
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
}
@end
