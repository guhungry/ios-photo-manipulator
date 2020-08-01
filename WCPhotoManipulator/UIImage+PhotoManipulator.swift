//
//  UIImage+PhotoManipulator.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

public extension UIImage {
    class func hasAlpha(_ image: UIImage) -> Bool {
        switch (image.cgImage?.alphaInfo) {
            case .none, .noneSkipLast, .noneSkipFirst: return false;
            default: return true
        }
    }
    
    @objc func hasAlpha() -> Bool {
        switch (self.cgImage?.alphaInfo) {
            case .none, .noneSkipLast, .noneSkipFirst: return false;
            default: return true
        }
    }
    
    // Crop & Resize
    @objc func crop(_ region: CGRect) -> UIImage? {
        let targetSize = region.size;
        let origin = CGPoint(x: -region.origin.x, y: -region.origin.y)
        let targetRect = CGRect(origin: origin, size: size)
        let transform = BitmapUtils.transformFromTargetRect(size, targetRect: targetRect)
        
        return BitmapUtils.transform(self, size: targetSize, scale: scale, transform: transform)
    }
    
    @objc func resize(_ targetSize: CGSize, scale: CGFloat) -> UIImage? {
        let targetRect = BitmapUtils.targetRect(size, destSize: targetSize, destScale: 1, resizeMode: .Contain)
        let transform = BitmapUtils.transformFromTargetRect(size, targetRect: targetRect)

        return BitmapUtils.transform(self, size: targetSize, scale: scale, transform: transform)
    }
    
    @objc func crop(_ region: CGRect, targetSize: CGSize) -> UIImage? {
        return crop(region)?.resize(targetSize, scale: scale)
    }

    // Text
    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat, scale: CGFloat) -> UIImage? {
        let opaque = !hasAlpha()
        UIGraphicsBeginImageContextWithOptions(self.size, opaque, scale)
        draw(in: CGRect(origin: .zero, size: self.size))

        var textStyles: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size),
            .foregroundColor: color,
        ]
        if (thickness > 0) {
            textStyles[.strokeColor] = color;
            textStyles[.strokeWidth] = thickness;
        }
        (text as NSString).draw(at: position, withAttributes: textStyles)
        
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return result
    }
    
    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat) -> UIImage? {
        return drawText(text, position: position, color: color, size: size, thickness: thickness, scale: scale)
    }
    
    // Overlay
    @objc func overlayImage(_ overlay: UIImage, position: CGPoint, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, scale);
        draw(in: CGRect(origin: .zero, size: size))
        let overlayRect = CGRect(origin: position, size: overlay.size )
        overlay.draw(in: overlayRect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
        
    }
    @objc func overlayImage(_ overlay: UIImage, position: CGPoint) -> UIImage? {
        return overlayImage(overlay, position: position, scale: scale)
    }
}
