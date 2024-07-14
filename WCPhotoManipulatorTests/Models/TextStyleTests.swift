//
//  TextStyleTests.swift
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 15/7/2567 BE.
//  Copyright © 2567 BE Woraphot Chokratanasombat. All rights reserved.
//

import XCTest

final class TextStyleTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testDescription_WithAllValues() throws {
        // Given
        let color = UIColor.red
        let font = UIFont.systemFont(ofSize: 12)
        let thickness: CGFloat = 1.5
        let rotation: CGFloat = 45
        let shadowRadius: CGFloat = 2.0
        let shadowOffsetX: Int = 3
        let shadowOffsetY: Int = 4
        let shadowColor: UIColor? = UIColor.black

        let textStyle = TextStyle(
            color: color,
            font: font,
            thickness: thickness,
            rotation: rotation,
            shadowRadius: shadowRadius,
            shadowOffsetX: shadowOffsetX,
            shadowOffsetY: shadowOffsetY,
            shadowColor: shadowColor
        )

        // When
        let description = textStyle.description

        // Then
        let expectedDescription = """
        TextStyle:
          color: \(color)
          font: \(font)
          thickness: \(thickness)
          rotation: \(rotation)
          shadowRadius: \(shadowRadius)
          shadowOffset: \(CGSize(width: shadowOffsetX, height: shadowOffsetY))
          shadowColor: \(String(describing: shadowColor))
        """

        XCTAssertEqual(description, expectedDescription)
    }
}
