//
//  UIImage+PhotoManipulator.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 22/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

@objc public extension UIImage {
    /**
     Crop image

     - Parameter cropRegion: Position and Size of Image to crop

     - Returns: Cropped image
     */
    @objc public func crop(region: CGRect) -> UIImage? {
        let targetRect = CGRect(x: -region.origin.x, y: -region.origin.y, width: self.size.width, height: self.size.width)
        let operation = BitmapUtils.transformFromTargetRect(self.size, targetRect)

        return BitmapUtils.transform(self, region.size, self.scale, operation)
    }

    /**
     Resize image to targetSize

     - Parameter targetSize: Target Image Size
     - Parameter scale: Scale of result image

     - Returns: Resized image
     */
    @objc public func resize(targetSize: CGSize, scale: CGFloat) -> UIImage? {
        let rect = BitmapUtils.targetRect(self.size, targetSize, 1, .cover)
        let operation = BitmapUtils.transformFromTargetRect(self.size, rect)
        return BitmapUtils.transform(self, targetSize, scale, operation)
    }

    @objc public func resize(targetSize: CGSize) -> UIImage? {
        return resize(targetSize: targetSize, scale: self.scale)
    }

    /**
     Crop and resize image

     - Parameter cropRegion: Position and Size of Image to crop
     - Parameter targetSize: Target Image Size

     - Returns: Cropped and resized image
     */
    @objc func crop(region: CGRect, targetSize: CGSize) -> UIImage? {
        return self.crop(region: region)?.resize(targetSize: targetSize, scale: self.scale)
    }

    @objc public func drawText(_ text: NSString, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat, scale: CGFloat) -> UIImage? {
        let opaque = !self.hasAlpha()
        UIGraphicsBeginImageContextWithOptions(self.size, opaque, scale)

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

        var textStyles = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor: color,
            ] as [NSAttributedString.Key : Any]
        if (thickness > 0) {
            textStyles[NSAttributedString.Key.strokeColor] = color
            textStyles[NSAttributedString.Key.strokeWidth] = thickness
        }
        text.draw(at: position, withAttributes: textStyles)

        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()

        return result
    }

    @objc public func drawText(_ text: NSString, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat) -> UIImage? {
        return drawText(text, position: position, color: color, size: size, thickness: thickness, scale: self.scale)
    }

    @objc public func overlayImage(_ overlay: UIImage, position: CGPoint, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, scale)

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

        overlay.draw(in: CGRect(origin: position, size: overlay.size))

        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()

        return result
    }

    @objc public func overlayImage(_ overlay: UIImage, position: CGPoint) -> UIImage? {
        return overlayImage(overlay, position: position, scale: self.scale)
    }

    func hasAlpha() -> Bool {
        guard let image = self.cgImage else { return false }

        switch (image.alphaInfo) {
        case .none, .noneSkipLast, .noneSkipFirst:
            return false
        default:
            return true
        }
    }
}
