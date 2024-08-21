//
//  WCPhotoManipulatorTests.swift
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import XCTest
@testable import WCPhotoManipulator

class MimeUtilsSwiftTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testMimeTypePNG_ShouldReturnCorrectly() throws {
        XCTAssertEqual(MimeUtils.PNG, "image/png")
    }

    func testMimeTypeJPEG_ShouldReturnCorrectly() throws {
        XCTAssertEqual(MimeUtils.JPEG, "image/jpeg")
    }
    
    func testToExtension_ShouldReturnCorrectly() throws {
        XCTAssertEqual(MimeUtils.toExtension("image/png"), ".png")
        XCTAssertEqual(MimeUtils.toExtension("image/jpeg"), ".jpg")
        XCTAssertEqual(MimeUtils.toExtension("invalid"), ".jpg")
    }
}
