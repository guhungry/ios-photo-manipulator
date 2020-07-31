//
//  BitmapUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

@objc public class BitmapUtils: NSObject {
    @objc public class func transform(_ image: UIImage, size: CGSize, scale: CGFloat, transform: CGAffineTransform) -> UIImage? {
        if size.width <= 0 || size.height <= 0 || scale <= 0 {
            return nil
        }
        let opaque = !UIImage.hasAlpha(image)
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        UIGraphicsGetCurrentContext()?.concatenate(transform)
        image.draw(at: CGPoint.zero)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    @objc public class func transformFromTargetRect(_ sourceSize: CGSize, targetRect: CGRect) -> CGAffineTransform {
        return CGAffineTransform
            .identity
            .translatedBy(x: targetRect.origin.x, y: targetRect.origin.y)
            .scaledBy(x: targetRect.size.width / sourceSize.width, y: targetRect.size.height / sourceSize.height)
    }
    
    @objc public class func targetRect(_ sourceSize: CGSize, destSize: CGSize, destScale: CGFloat, resizeMode: ResizeMode) -> CGRect {
        
        if destSize == CGSize.zero {
            return CGRect(origin: CGPoint.zero, size: sourceSize)
        }
        

        let aspect = sourceSize.width / sourceSize.height
        let fixedDestSize = fixSize(destSize, aspect)

        // Calculate target aspect ratio if needed
        var targetAspect = CGFloat(0.0)
        var fixResizeMode = resizeMode
        if resizeMode != .Stretch {
            targetAspect = fixedDestSize.width / fixedDestSize.height
            if aspect == targetAspect {
                fixResizeMode = .Stretch
            }
        }

        switch (fixResizeMode) {
        case .Contain:
                return calculateResizeContain(targetAspect <= aspect, aspect, fixedDestSize, destScale)

        case .Cover:
            return calculateResizeCover(targetAspect, aspect, fixedDestSize, destScale)

        default: // ResizeModeStretch
            return CGRect(origin: .zero, size: BitmapUtils.ceilSize(fixedDestSize, scale: destScale))
        }
    }
    
    private class func calculateResizeCover(_ targetAspect: CGFloat, _ aspect: CGFloat, _ size: CGSize, _ scale: CGFloat) -> CGRect {
        var width: CGFloat
        var height: CGFloat
        var destWidth: CGFloat
        var destHeight: CGFloat

        if targetAspect <= aspect { // target is taller than content
            height = size.height
            width = size.height * aspect
            destWidth = size.height * targetAspect
            let origin = CGPoint(
                x: BitmapUtils.floor((destWidth - width) / 2, scale: scale),
                y: 0
            )
            return CGRect(origin: origin, size: BitmapUtils.ceilSize(CGSize(width: width, height: height), scale: scale))
        }
        
        // target is wider than content
        width = size.width;
        height = size.width / aspect
        destHeight = size.width / targetAspect
        let origin = CGPoint(
            x: 0,
            y: BitmapUtils.floor((destHeight - height) / 2, scale: scale)
        )
        return CGRect(origin: origin, size: BitmapUtils.ceilSize(CGSize(width: width, height: height), scale: scale))
    }
    
    private class func calculateResizeContain(_ modeTall: Bool, _ aspect: CGFloat, _ size: CGSize, _ scale: CGFloat) -> CGRect {
        var width: CGFloat
        var height: CGFloat

        if modeTall { // target is taller than content
            width = size.width;
            height = size.width / aspect
        } else { // target is wider than content
            
            height = size.height
            width = size.height * aspect
        }
        
        let origin = CGPoint(
            x: BitmapUtils.floor(((size.width - width) / 2), scale: scale),
            y: BitmapUtils.floor(((size.height - height) / 2), scale: scale)
        )
        return CGRect(origin: origin, size: BitmapUtils.ceilSize(CGSize(width: width, height: height), scale: scale))
    }
    
    private class func fixSize(_ size: CGSize, _ aspectRatio: CGFloat) -> CGSize {
        // If only one dimension in destSize is non-zero (for example, an Image
        // with `flex: 1` whose height is indeterminate), calculate the unknown
        // dimension based on the aspect ratio of sourceSize
        if (size.width == 0) {
            return CGSize(width: size.height * aspectRatio, height: size.height)
        }
        if (size.height == 0) {
            return CGSize(width: size.width, height: size.width / aspectRatio)
        }
        
        return size
    }

    // CGFloat
    @objc public class func ceil(_ value: CGFloat, scale: CGFloat) -> CGFloat {
        return (value * scale).rounded(.up) / scale
    }
    @objc public class func floor(_ value: CGFloat, scale: CGFloat) -> CGFloat {
        return (value * scale).rounded(.down) / scale
    }

    // CGSize
    @objc public class func ceilSize(_ size: CGSize, scale: CGFloat) -> CGSize {
        return CGSize(
            width: ceil(size.width, scale: scale),
            height: ceil(size.height, scale: scale)
        )
    }
}
