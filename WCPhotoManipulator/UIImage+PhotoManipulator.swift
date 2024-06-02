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
        guard let alpha = image.cgImage?.alphaInfo else {
            return false
        }
        switch (alpha) {
            case .none, .noneSkipLast, .noneSkipFirst: return false;
            default: return true
        }
    }
    
    @objc func hasAlpha() -> Bool {
        return UIImage.hasAlpha(self)
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
    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, font: UIFont, thickness: CGFloat, rotation: CGFloat, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: position.x, y: position.y)
            context.rotate (by: -rotation * CGFloat.pi / 180.0) //45˚
            context.translateBy(x: -position.x, y: -position.y)
        }
        
        var textStyles: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        if (thickness > 0) {
            textStyles[.strokeColor] = color;
            textStyles[.strokeWidth] = thickness;
        }
        (text as NSString).draw(at: position, withAttributes: textStyles)
        
        let rotatedImageWithText = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        

        let opaque = !hasAlpha()
        UIGraphicsBeginImageContextWithOptions(self.size, opaque, scale)

        let rect = CGRect(origin: .zero, size: self.size)
        draw(in: rect)
        rotatedImageWithText?.draw(at: .zero)
        
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return result
    }

    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, font: UIFont, thickness: CGFloat, rotation: CGFloat) -> UIImage? {
            return drawText(text, position: position, color: color, font:font, thickness: thickness, rotation: rotation, scale: scale)
    }

    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat, rotation: CGFloat, scale: CGFloat) -> UIImage? {
        return drawText(text, position: position, color: color, font: UIFont.systemFont(ofSize: size), thickness: thickness, rotation: rotation, scale: scale)
    }
    
    @objc func drawText(_ text: String, position: CGPoint, color: UIColor, size: CGFloat, thickness: CGFloat, rotation: CGFloat) -> UIImage? {
        return drawText(text, position: position, color: color, size: size, thickness: thickness, rotation: rotation, scale: scale)
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
    
    // Flip
    @objc func flip(_ flipMode: FlipMode) -> UIImage {
        if (flipMode == .None) { return self }

        let cgimage = ciImage().transformed(by: flipMode.transform())
        return UIImage(ciImage: cgimage)
    }
    
    // Flip
    @objc func rotate(_ rotateMode: RotationMode) -> UIImage {
        if (rotateMode == .None) { return self }

        let cgimage = ciImage().transformed(by: rotateMode.transform())
        return UIImage(ciImage: cgimage)
    }
    
    // Flip
    @objc func ciImage() -> CIImage {
        return (ciImage != nil) ? ciImage! : CIImage(cgImage: cgImage!)
    }
}
