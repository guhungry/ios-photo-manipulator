//
//  UIImage+PhotoManipulatorSwiftTests.swift
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 1/8/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import XCTest

class UIImage_PhotoManipulatorSwiftTests: XCTestCase {
    var image: UIImage! = nil
    var overlay: UIImage! = nil
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        image = nil
        overlay = nil
    }
    
    func testHasAlpha_WhenNoData_ShouldReturnFalse() throws {
        image = UIImage.init()
        XCTAssertNotNil(image)
        XCTAssertTrue(image.responds(to: Selector(("hasAlpha"))))
        XCTAssertFalse(image.hasAlpha())
    }

    func testHasAlpha_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "overlay.png")
        XCTAssertNotNil(image)
        XCTAssertTrue(image.responds(to: Selector(("hasAlpha"))))
        XCTAssertTrue(image.hasAlpha())
    
        
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
        XCTAssertFalse(image.hasAlpha())
    }

    func testCrop_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        let expectedColor = image.color(at: CGPoint(x: 52, y: 89))
        XCTAssertNotNil(image)
    
    
        image = image.crop(CGRect(x: 52, y: 89, width: 65, height: 74))
        let actualColor = image.color(at: CGPoint(x: 0, y: 0))
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 65, height: 74))
        XCTAssertEqual(actualColor, expectedColor)
    }

    func testResize_ShouldReturnSizeCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
    
        image = image.resize(CGSize(width: 55, height: 99), scale: 1)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 55, height: 99))
    }

    func testCropAndResize_ShouldReturnSizeCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        let expectedColor = image.color(at: CGPoint(x: 61, y: 144))
        XCTAssertNotNil(image)
    
    
        image = image.crop(CGRect(x: 61, y: 144, width: 166, height: 35), targetSize: CGSize(width: 332, height: 70))
        let actualColor = image.color(at: CGPoint(x: 0, y: 0))
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 332, height: 70))
        XCTAssertEqual(actualColor, expectedColor)
    }

    // Draw Text
    func testDrawText_WhenUseShadow_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)

        let style = TextStyle(color: .blue, font: UIFont.systemFont(ofSize: 102), thickness: 0, rotation: 14, shadowRadius: 3, shadowOffsetX: 4, shadowOffsetY: 10, shadowColor: UIColor.green)
        image = image.drawText("Draw Shadow", position: CGPoint(x: 15, y: 66), style: style)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    func testDrawText_WhenUseFontAndNoScale_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)

        let style = TextStyle(color: .blue, font: UIFont.systemFont(ofSize: 102), thickness: 5, rotation: 0)
        image = image.drawText("Test Text To Draw", position: CGPoint(x: 15, y: 66), style: style)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    func testDrawText_WhenNoScale_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)

        let style = TextStyle(color: .blue, font: UIFont.systemFont(ofSize: 42), thickness: 5, rotation: 0)
        image = image.drawText("Test Text To Draw", position: CGPoint(x: 15, y: 66), style: style)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    func testDrawText_WhenHasScale_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)

        let style = TextStyle(color: .blue, font: UIFont.systemFont(ofSize: 42), thickness: 5, rotation: 0)
        image = image.drawText("Test Text To Draw", position: CGPoint(x: 15, y: 66), style: style, scale: 2)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }
    
    func testDrawText_WhenRotation_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)

        let style = TextStyle(color: .blue, size: 42, thickness: 5, rotation: -30)
        image = image.drawText("Test Text To Rotate Draw", position: CGPoint(x: 15, y: 66), style: style, scale: 2)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    // Overlay Image
    func testOverlayImage_WhenNoScale_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        overlay = UIImage.init(namedTest: "overlay.png")
        XCTAssertNotNil(image)
    
        image = image.overlayImage(overlay, position: CGPoint(x: 66, y: 115))
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    func testOverlayImage_WhenHasScale_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        overlay = UIImage.init(namedTest: "overlay.png")
        XCTAssertNotNil(image)
    
        image = image.overlayImage(overlay, position: CGPoint(x: 66, y: 115), scale: 3)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }

    // Flip
    func testFlip_WhenHasHorizontal_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
        image = image.flip(.Horizontal)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }
    
    func testFlip_WhenHasVertical_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
        image = image.flip(.Vertical)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }
    
    func testFlip_WhenHasBoth_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
        image = image.flip(.Both)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, CGSize(width: 800, height: 530))
    }
    
    func testFlip_WhenHasNone_ShouldDoNothing() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
        let actual = image.flip(.None)
        XCTAssertNotNil(image)
        XCTAssertIdentical(actual, image)
        XCTAssertEqual(actual.size, CGSize(width: 800, height: 530))
    }
    
    func testFlip_WhenHasMultiple_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
    
        let image1 = image.flip(.Vertical)
        let image2 = image1.flip(.Horizontal)
        let image3 = image2.flip(.Vertical)
        let image4 = image3.flip(.Horizontal)
        XCTAssertNotNil(image4)
        XCTAssertEqual(image4.size, CGSize(width: 800, height: 530))
    }

    // Rotate
    func testRotate_WhenR90_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
        
        let actual = image.rotate(.R90)
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual.size, CGSize(width: 530, height: 800))
    }
    
    func testRotate_WhenR180_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
        
        let actual = image.rotate(.R180)
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual.size, CGSize(width: 800, height: 530))
    }
    
    func testRotate_WhenR270_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
        
        let actual = image.rotate(.R270)
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual.size, CGSize(width: 530, height: 800))
    }
    
    func testRotate_WhenNone_ShouldReturnCorrectly() throws {
        image = UIImage.init(namedTest: "background.jpg")
        XCTAssertNotNil(image)
        
        let actual = image.rotate(.None)
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual.size, CGSize(width: 800, height: 530))
    }
}
