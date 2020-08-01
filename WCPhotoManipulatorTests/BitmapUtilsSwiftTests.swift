//
//  BitmapUtilsSwiftTests.swift
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 1/8/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import XCTest
@testable import WCPhotoManipulator

class BitmapUtilsSwiftTests: XCTestCase {
    private var image: UIImage! = nil

    override func tearDownWithError() throws {
        image = nil
    }
    
    ////////////////////////////
    /// ceil
    ///////////////////////////
    func testCeil_ShouldReturnValueCorrectly() throws {
        XCTAssertEqual(BitmapUtils.ceil(5, scale: 1), 5)
        XCTAssertEqual(BitmapUtils.ceil(4.8, scale: 1), 5)
        XCTAssertEqual(BitmapUtils.ceil(4.5, scale: 1), 5)
        XCTAssertEqual(BitmapUtils.ceil(4.1, scale: 1), 5)
        XCTAssertEqual(BitmapUtils.ceil(5, scale: 2), 5)
        XCTAssertEqual(BitmapUtils.ceil(4.8, scale: 2), 5)
        XCTAssertEqual(BitmapUtils.ceil(4.5, scale: 2), 4.5)
        XCTAssertEqual(BitmapUtils.ceil(4.1, scale: 2), 4.5)
    }
    
    ////////////////////////////
    /// ceil
    ///////////////////////////
    func testFloor_ShouldReturnValueCorrectly() throws {
        XCTAssertEqual(BitmapUtils.floor(5, scale: 1), 5)
        XCTAssertEqual(BitmapUtils.floor(4.8, scale: 1), 4)
        XCTAssertEqual(BitmapUtils.floor(4.5, scale: 1), 4)
        XCTAssertEqual(BitmapUtils.floor(4.1, scale: 1), 4)
        XCTAssertEqual(BitmapUtils.floor(5, scale: 2), 5)
        XCTAssertEqual(BitmapUtils.floor(4.8, scale: 2), 4.5)
        XCTAssertEqual(BitmapUtils.floor(4.5, scale: 2), 4.5)
        XCTAssertEqual(BitmapUtils.floor(4.1, scale: 2), 4)
    }

    ////////////////////////////
    /// ceilSize
    ///////////////////////////
    func testCeilSize_ShouldReturnValueCorrectly() throws {
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 5, height: 6), scale: 1), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.8, height: 5.8), scale: 1), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.5, height: 5.5), scale: 1), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.1, height: 5.1), scale: 1), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 5, height: 6), scale: 2), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.8, height: 5.8), scale: 2), CGSize(width: 5, height: 6))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.5, height: 5.5), scale: 2), CGSize(width: 4.5, height: 5.5))
        XCTAssertEqual(BitmapUtils.ceilSize(CGSize(width: 4.1, height: 5.1), scale: 2), CGSize(width: 4.5, height: 5.5))
    }

    ////////////////////////////
    /// transformFromTargetRect
    ///////////////////////////
    func testTransformFromTargetRect_ShouldReturnValueCorrectly() throws {
        let sourceSize = CGSize(width: 40, height: 90)
        let targetRect = CGRect(x: 30, y: 50, width: 92, height: 35)
        let transform = BitmapUtils.transformFromTargetRect(sourceSize, targetRect:targetRect)
        
        XCTAssertEqual(transform.tx, 30)
        XCTAssertEqual(transform.ty, 50)
        XCTAssertEqual(transform.a, CGFloat(exactly: 92.0 / 40))
        XCTAssertEqual(transform.b, 0)
        XCTAssertEqual(transform.c, 0)
        XCTAssertEqual(transform.d, CGFloat(exactly: 35.0 / 90))
    }

    ////////////////////////////
    /// transform
    ///////////////////////////
    func testTransform_WhenNoSizeOrScale_ShouldReturnNil() throws {
        image = UIImage()
        
        XCTAssertNil(BitmapUtils.transform(image, size:.zero, scale:0, transform:.identity))
        XCTAssertNil(BitmapUtils.transform(image, size:CGSize(width: 0, height: 6), scale:7, transform:.identity))
        XCTAssertNil(BitmapUtils.transform(image, size:CGSize(width: 6, height: 0), scale:7, transform:.identity))
        XCTAssertNil(BitmapUtils.transform(image, size:CGSize(width: 6, height: 8), scale:0, transform:.identity))
    }
    
    func testTransform_WhenValidSamePosition_ShouldReturnNewImage() throws {
        image = UIImage.init(namedTest: "background.jpg")
        let expectedColor = image.color(at: CGPoint(x: 70, y: 55))
        XCTAssertEqual(image?.size, CGSize(width: 800, height: 530))
        XCTAssertEqual(image?.scale, 1)
        
        image = BitmapUtils.transform(image, size:CGSize(width: 800, height: 530), scale:1, transform:.identity)
        let actualColor = image.color(at: CGPoint(x: 70, y: 55))
        XCTAssertEqual(image?.size, CGSize(width: 800, height: 530))
        XCTAssertEqual(image?.scale, 1)
        XCTAssertEqual(actualColor, expectedColor)
    }
    
    func testTransform_WhenValidSamePositionAndTransparentImage_ShouldReturnNewImage() throws {
        image = UIImage.init(namedTest: "overlay.png")
        let expectedColor = image.color(at: CGPoint(x: 70, y: 55))
        XCTAssertEqual(image?.size, CGSize(width: 200, height: 141))
        XCTAssertEqual(image?.scale, 1)
        
        image = BitmapUtils.transform(image, size:CGSize(width: 200, height: 141), scale:1, transform:.identity)
        let actualColor = image.color(at: CGPoint(x: 70, y: 55))
        XCTAssertEqual(image?.size, CGSize(width: 200, height: 141))
        XCTAssertEqual(image?.scale, 1)
        XCTAssertEqual(actualColor, expectedColor)
    }
    
    func testTransform_WhenValidDiffPosition_ShouldReturnNewImage() throws {
        image = UIImage.init(namedTest: "background.jpg")
        let expectedColor = image.color(at: CGPoint(x: 22, y: 46))
        XCTAssertEqual(image?.size, CGSize(width: 800, height: 530))
        XCTAssertEqual(image?.scale, 1)
        
        let translate = BitmapUtils.transformFromTargetRect(CGSize(width: 800, height: 530), targetRect:CGRect(x: 35, y: 43, width: 800, height: 530))
        image = BitmapUtils.transform(image, size:CGSize(width: 800, height: 530), scale:1, transform:translate)
        let actualColor = image.color(at: CGPoint(x: 57, y: 89))
        XCTAssertEqual(image?.size, CGSize(width: 800, height: 530))
        XCTAssertEqual(image?.scale, 1)
        XCTAssertEqual(actualColor, expectedColor)
    }

    ////////////////////////////
    /// targetRect
    ///////////////////////////
    func testTargetRect_WhenStrech_ShouldOriginZero() throws {
        // Bigger
        var targetRect = BitmapUtils.targetRect(CGSize(width: 80, height: 90), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Stretch)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 0, width: 60, height: 30))
        
        // Smaller
        targetRect = BitmapUtils.targetRect(CGSize(width: 20, height: 10), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Stretch)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 0, width: 60, height: 30))
    }
    
    func testTargetRect_WhenCoverAndBigger_ShouldTransformCorrectly() throws {
        var targetRect = BitmapUtils.targetRect(CGSize(width: 80, height: 90), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: -19, width: 60, height: 68))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 90, height: 80), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: -12, width: 60, height: 54))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 80, height: 90), destSize:CGSize(width: 30, height: 60), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: -12, y: 0, width: 54, height: 60))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 90, height: 80), destSize:CGSize(width: 30, height: 60), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: -19, y: 0, width: 68, height: 60))
    }
    
    func testTargetRect_WhenCoverAndSmaller_ShouldTransformCorrectly() throws {
        var targetRect = BitmapUtils.targetRect(CGSize(width: 60, height: 30), destSize:CGSize(width: 80, height: 90), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: -50, y: 0, width: 180, height: 90))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 80, height: 90), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: -35, width: 80, height: 160))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 60, height: 30), destSize:CGSize(width: 90, height: 80), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: -35, y: 0, width: 160, height: 80))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 90, height: 80), destScale:1, resizeMode:.Cover)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: -50, width: 90, height: 180))
    }
    
    func testTargetRect_WhenContainBigger_ShouldTransformCorrectly() throws {
        var targetRect = BitmapUtils.targetRect(CGSize(width: 80, height: 90), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 16, y: 0, width: 27, height: 30))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 90, height: 80), destSize:CGSize(width: 60, height: 30), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 13, y: 0, width: 34, height: 30))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 80, height: 90), destSize:CGSize(width: 30, height: 60), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 13, width: 30, height: 34))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 90, height: 80), destSize:CGSize(width: 30, height: 60), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 16, width: 30, height: 27))
    }
    
    func testTargetRect_WhenContainSmaller_ShouldTransformCorrectly() throws {
        var targetRect = BitmapUtils.targetRect(CGSize(width: 60, height: 30), destSize:CGSize(width: 90, height: 80), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 17, width: 90, height: 45))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 90, height: 80), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 25, y: 0, width: 40, height: 80))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 60, height: 30), destSize:CGSize(width: 80, height: 90), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 25, width: 80, height: 40))
        
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 80, height: 90), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 17, y: 0, width: 45, height: 90))
    }
    
    func testTargetRect_WhenZeroSizeHeightWidth() throws {
        // Dest Size = Zero: Use Source Size
        var targetRect = BitmapUtils.targetRect(CGSize(width: 60, height: 30), destSize:.zero, destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 0, width: 60, height: 30))
        
        // Dest Height = Zero: Use Source Aspect Ratio
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 90, height: 0), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 0, width: 90, height: 180))
        
        // Dest Width = Zero: Use Source Aspect Ratio
        targetRect = BitmapUtils.targetRect(CGSize(width: 30, height: 60), destSize:CGSize(width: 0, height: 90), destScale:1, resizeMode:.Contain)
        XCTAssertEqual(targetRect, CGRect(x: 0, y: 0, width: 45, height: 90))
    }
}
