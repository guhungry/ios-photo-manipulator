//
//  BitmapUtilsTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Helpers/UIImage+Testing.h"
@import WCPhotoManipulator;

@interface BitmapUtilsObjCTests : XCTestCase

@end

@implementation BitmapUtilsObjCTests {
    UIImage *image;
}

- (void)tearDown {
    image = nil;
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

////////////////////////////
/// transformFromTargetRect
///////////////////////////
- (void)testTransformFromTargetRect_ShouldReturnValueCorrectly {
    CGSize sourceSize = CGSizeMake(40, 90);
    CGRect targetRect = CGRectMake(30, 50, 92, 35);
    CGAffineTransform transform = [BitmapUtils transformFromTargetRect:sourceSize targetRect:targetRect];
    
    XCTAssertEqual(transform.tx, 30);
    XCTAssertEqual(transform.ty, 50);
    XCTAssertEqual(transform.a, (CGFloat)92 / 40);
    XCTAssertEqual(transform.b, 0);
    XCTAssertEqual(transform.c, 0);
    XCTAssertEqual(transform.d, (CGFloat)35 / 90);
}

////////////////////////////
/// transform
///////////////////////////
- (void)testTransform_WhenNoSizeOrScale_ShouldReturnNil {
    image = [UIImage new];
    
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(0, 0) scale:0 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(0, 6) scale:7 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(6, 0) scale:7 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(6, 8) scale:0 transform:CGAffineTransformIdentity]);
}

- (void)testTransform_WhenValidSamePosition_ShouldReturnNewImage {
    image = [UIImage imageNamedTest:@"background.jpg"];
    UIColor *expectedColor = [image colorAt:CGPointMake(70, 55)];
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
    XCTAssertEqual(image.scale, 1);
    
    image = [BitmapUtils transform:image size:CGSizeMake(800, 530) scale:1 transform:CGAffineTransformIdentity];
    UIColor *actualColor = [image colorAt:CGPointMake(70, 55)];
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
    XCTAssertEqual(image.scale, 1);
    XCTAssert([actualColor isEqual:expectedColor]);
}

- (void)testTransform_WhenValidSamePositionAndTransparentImage_ShouldReturnNewImage {
    image = [UIImage imageNamedTest:@"overlay.png"];
    UIColor *expectedColor = [image colorAt:CGPointMake(70, 55)];
    XCTAssertEqual(image.size.width, 200);
    XCTAssertEqual(image.size.height, 141);
    XCTAssertEqual(image.scale, 1);
    
    image = [BitmapUtils transform:image size:CGSizeMake(200, 141) scale:1 transform:CGAffineTransformIdentity];
    UIColor *actualColor = [image colorAt:CGPointMake(70, 55)];
    XCTAssertEqual(image.size.width, 200);
    XCTAssertEqual(image.size.height, 141);
    XCTAssertEqual(image.scale, 1);
    XCTAssert([actualColor isEqual:expectedColor]);
}

- (void)testTransform_WhenValidDiffPosition_ShouldReturnNewImage {
    image = [UIImage imageNamedTest:@"background.jpg"];

    UIColor *expectedColor = [image colorAt:CGPointMake(22, 46)];
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
    XCTAssertEqual(image.scale, 1);
    
    CGAffineTransform translate = [BitmapUtils transformFromTargetRect:CGSizeMake(800, 530) targetRect:CGRectMake(35, 43, 800, 530)];
    image = [BitmapUtils transform:image size:CGSizeMake(800, 530) scale:1 transform:translate];
    UIColor *actualColor = [image colorAt:CGPointMake(57, 89)];
    XCTAssertEqual(image.size.width, 800);
    XCTAssertEqual(image.size.height, 530);
    XCTAssertEqual(image.scale, 1);
    XCTAssert([actualColor isEqual:expectedColor]);
}

////////////////////////////
/// targetRect
///////////////////////////
- (void)testTargetRect_WhenStrech_ShouldOriginZero {
    // Bigger
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(80, 90) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeStretch];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 60);
    XCTAssertEqual(targetRect.size.height, 30);
    
    // Smaller
    targetRect = [BitmapUtils targetRect:CGSizeMake(20, 10) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeStretch];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 60);
    XCTAssertEqual(targetRect.size.height, 30);
}

- (void)testTargetRect_WhenCoverAndBigger_ShouldTransformCorrectly {
    // Bigger
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(80, 90) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, -19);
    XCTAssertEqual(targetRect.size.width, 60);
    XCTAssertEqual(targetRect.size.height, 68);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(90, 80) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, -12);
    XCTAssertEqual(targetRect.size.width, 60);
    XCTAssertEqual(targetRect.size.height, 54);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(80, 90) destSize:CGSizeMake(30, 60) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, -12);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 54);
    XCTAssertEqual(targetRect.size.height, 60);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(90, 80) destSize:CGSizeMake(30, 60) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, -19);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 68);
    XCTAssertEqual(targetRect.size.height, 60);
}

- (void)testTargetRect_WhenCoverAndSmaller_ShouldTransformCorrectly {
    // Bigger
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(60, 30) destSize:CGSizeMake(80, 90) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, -50);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 180);
    XCTAssertEqual(targetRect.size.height, 90);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(80, 90) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, -35);
    XCTAssertEqual(targetRect.size.width, 80);
    XCTAssertEqual(targetRect.size.height, 160);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(60, 30) destSize:CGSizeMake(90, 80) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, -35);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 160);
    XCTAssertEqual(targetRect.size.height, 80);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(90, 80) destScale:1 resizeMode:ResizeModeCover];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, -50);
    XCTAssertEqual(targetRect.size.width, 90);
    XCTAssertEqual(targetRect.size.height, 180);
}

- (void)testTargetRect_WhenContainBigger_ShouldTransformCorrectly {
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(80, 90) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 16);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 27);
    XCTAssertEqual(targetRect.size.height, 30);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(90, 80) destSize:CGSizeMake(60, 30) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 13);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 34);
    XCTAssertEqual(targetRect.size.height, 30);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(80, 90) destSize:CGSizeMake(30, 60) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 13);
    XCTAssertEqual(targetRect.size.width, 30);
    XCTAssertEqual(targetRect.size.height, 34);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(90, 80) destSize:CGSizeMake(30, 60) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 16);
    XCTAssertEqual(targetRect.size.width, 30);
    XCTAssertEqual(targetRect.size.height, 27);
}

- (void)testTargetRect_WhenContainSmaller_ShouldTransformCorrectly {
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(60, 30) destSize:CGSizeMake(90, 80) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 17);
    XCTAssertEqual(targetRect.size.width, 90);
    XCTAssertEqual(targetRect.size.height, 45);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(90, 80) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 25);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 40);
    XCTAssertEqual(targetRect.size.height, 80);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(60, 30) destSize:CGSizeMake(80, 90) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 25);
    XCTAssertEqual(targetRect.size.width, 80);
    XCTAssertEqual(targetRect.size.height, 40);
    
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(80, 90) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 17);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 45);
    XCTAssertEqual(targetRect.size.height, 90);
}

- (void)testTargetRect_WhenZeroSizeHeightWidth {
    // Dest Size = Zero: Use Source Size
    CGRect targetRect = [BitmapUtils targetRect:CGSizeMake(60, 30) destSize:CGSizeMake(0, 0) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 60);
    XCTAssertEqual(targetRect.size.height, 30);
    
    // Dest Height = Zero: Use Source Aspect Ratio
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(90, 0) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 90);
    XCTAssertEqual(targetRect.size.height, 180);
    
    // Dest Width = Zero: Use Source Aspect Ratio
    targetRect = [BitmapUtils targetRect:CGSizeMake(30, 60) destSize:CGSizeMake(0, 90) destScale:1 resizeMode:ResizeModeContain];
    XCTAssertEqual(targetRect.origin.x, 0);
    XCTAssertEqual(targetRect.origin.y, 0);
    XCTAssertEqual(targetRect.size.width, 45);
    XCTAssertEqual(targetRect.size.height, 90);
}

@end
