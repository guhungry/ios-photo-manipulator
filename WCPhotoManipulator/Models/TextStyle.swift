//
//  TextStyle.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 12/7/24.
//  Copyright © 2024 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

/// A class representing the style of text, including color, font, thickness, rotation, and shadow properties.
@objc public class TextStyle : NSObject {
    /// The color of the text.
    let color: UIColor
    /// The font of the text.
    let font: UIFont
    /// The thickness of the text. Default value is 0.
    let thickness: CGFloat
    /// The rotation angle of the text in degrees. Default value is 0.
    let rotation: CGFloat
    /// The blur radius of the text's shadow. Default value is 0.
    let shadowRadius: CGFloat
    /// The offset of the text's shadow. Default value is CGSize(width: 0, height: 0).
    let shadowOffset: CGSize
    /// The color of the text's shadow. Default value is nil (no shadow color).
    let shadowColor: UIColor?
    
    /// Computed property that creates and returns an NSShadow object based on the shadow properties.
    var shadow: NSShadow {
        let shadow = NSShadow()
        shadow.shadowBlurRadius = shadowRadius
        shadow.shadowOffset = shadowOffset
        shadow.shadowColor = shadowColor
        return shadow
    }

    /// Initializes a new TextStyle object with specified properties.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - font: The font of the text.
    ///   - thickness: The thickness of the text. Default is 0.
    ///   - rotation: The rotation angle of the text in degrees. Default is 0.
    ///   - shadowRadius: The blur radius of the shadow. Default is 0.
    ///   - shadowOffsetX: The horizontal offset of the shadow. Default is 0.
    ///   - shadowOffsetY: The vertical offset of the shadow. Default is 0.
    ///   - shadowColor: The color of the shadow. Default is nil.
    @objc public init(color: UIColor, font: UIFont, thickness: CGFloat = 0, rotation: CGFloat = 0, shadowRadius: CGFloat = 0, shadowOffsetX: Int = 0, shadowOffsetY: Int = 0, shadowColor: UIColor? = nil) {
        self.color = color
        self.font = font
        self.thickness = thickness
        self.rotation = rotation
        self.shadowRadius = shadowRadius
        self.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
        self.shadowColor = shadowColor
    }

    /// Convenience initializer with only color and font.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - font: The font of the text.
    @objc public convenience init(color: UIColor, font: UIFont) {
        self.init(color: color, font: font)
    }

    /// Convenience initializer with color, font, and thickness.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - font: The font of the text.
    ///   - thickness: The thickness of the text.
    @objc public convenience init(color: UIColor, font: UIFont, thickness: CGFloat) {
        self.init(color: color, font: font, thickness: thickness)
    }

    /// Convenience initializer with color, font, thickness, and rotation.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - font: The font of the text.
    ///   - thickness: The thickness of the text.
    ///   - rotation: The rotation angle of the text in degrees.
    @objc public convenience init(color: UIColor, font: UIFont, thickness: CGFloat, rotation: CGFloat) {
        self.init(color: color, font: font, thickness: thickness, rotation: rotation)
    }

    /// Convenience initializer with color, size, and other optional properties.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - size: The size of the text's font.
    ///   - thickness: The thickness of the text. Default is 0.
    ///   - rotation: The rotation angle of the text in degrees. Default is 0.
    ///   - shadowRadius: The blur radius of the shadow. Default is 0.
    ///   - shadowOffsetX: The horizontal offset of the shadow. Default is 0.
    ///   - shadowOffsetY: The vertical offset of the shadow. Default is 0.
    ///   - shadowColor: The color of the shadow. Default is nil.
    @objc public convenience init(color: UIColor, size: CGFloat, thickness: CGFloat = 0, rotation: CGFloat = 0, shadowRadius: CGFloat = 0, shadowOffsetX: Int = 0, shadowOffsetY: Int = 0, shadowColor: UIColor? = nil) {
        self.init(color: color, font: UIFont.systemFont(ofSize: size), thickness: thickness, rotation: rotation, shadowRadius: shadowRadius, shadowOffsetX: shadowOffsetX, shadowOffsetY: shadowOffsetY, shadowColor: shadowColor)
    }

    /// Convenience initializer with only color and size.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - size: The size of the text's font.
    @objc public convenience init(color: UIColor, size: CGFloat) {
        self.init(color: color, size: size)
    }

    /// Convenience initializer with color, size, and thickness.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - size: The size of the text's font.
    ///   - thickness: The thickness of the text.
    @objc public convenience init(color: UIColor, size: CGFloat, thickness: CGFloat) {
        self.init(color: color, size: size, thickness: thickness)
    }

    /// Convenience initializer with color, size, thickness, and rotation.
    ///
    /// - Parameters:
    ///   - color: The color of the text.
    ///   - size: The size of the text's font.
    ///   - thickness: The thickness of the text.
    ///   - rotation: The rotation angle of the text in degrees.
    @objc public convenience init(color: UIColor, size: CGFloat, thickness: CGFloat, rotation: CGFloat) {
        self.init(color: color, size: size, thickness: thickness, rotation: rotation)
    }

    public override var description: String {
        return """
        TextStyle:
          color: \(color)
          font: \(font)
          thickness: \(thickness)
          rotation: \(rotation)
          shadowRadius: \(shadowRadius)
          shadowOffset: \(shadowOffset)
          shadowColor: \(String(describing: shadowColor))
        """
    }
}
