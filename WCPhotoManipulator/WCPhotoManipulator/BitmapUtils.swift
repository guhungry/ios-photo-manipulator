//
//  BitmapUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 22/3/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

class BitmapUtils: NSObject {
    static func crop(_ image: UIImage, _ region: CGRect) -> UIImage? {
        let targetSize = region.size;
        let targetRect = CGRect(x: -region.origin.x, y: -region.origin.y, width: image.size.width, height: image.size.width)
        let operation = transformFromTargetRect(image.size, targetRect)

        return transform(image, targetSize, image.scale, operation)
    }
    
    static func resize(_ image: UIImage, _ targetSize: CGSize, _ scale: CGFloat) -> UIImage? {
        let rect = targetRect(image.size, targetSize, 1, .cover)
        let operation = transformFromTargetRect(image.size, rect)
        return transform(image, targetSize, scale, operation)
    }
    
    static func cropAndResize(image: UIImage, cropRegion: CGRect, targetSize: CGSize) -> UIImage? {
        guard let result = crop(image, cropRegion) else { return nil }
        
        return resize(result, targetSize, image.scale)
    }
    
    static func hasAlpha(_ image: CGImage?) -> Bool {
        guard let image = image else { return false }
        
        switch (image.alphaInfo) {
        case .none, .noneSkipLast, .noneSkipFirst:
            return false
        default:
            return true
        }
    }
    
    // Transform
    // https://github.com/facebook/react-native/blob/master/Libraries/Image/RCTImageUtils.m
    static func transform(_ image: UIImage, _ size: CGSize, _ scale: CGFloat, _ transform: CGAffineTransform) -> UIImage? {
        if (size.width <= 0 || size.height <= 0 || scale <= 0) {
            return nil;
        }
        
        let opaque = !hasAlpha(image.cgImage)
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        UIGraphicsGetCurrentContext()?.concatenate(transform)
        image.draw(at: CGPoint.zero)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result;
    }
    
    static func transformFromTargetRect(_ sourceSize: CGSize, _ targetRect: CGRect) -> CGAffineTransform {
        let transform = CGAffineTransform.identity
            .translatedBy(x: targetRect.origin.x, y: targetRect.origin.y)
            .scaledBy(x: targetRect.size.width / sourceSize.width, y: targetRect.size.height / sourceSize.height)
        return transform
    }
    
    // Rect
    static func targetRect(_ sourceSize: CGSize, _ destSize: CGSize, _ destScale: CGFloat, _ resizeMode: ResizeMode) -> CGRect {
        var targetSize = destSize
        var mutableSourceSize = sourceSize
        if (targetSize.equalTo(CGSize.zero)) {
            // Assume we require the largest size available
            return CGRect(origin: CGPoint.zero, size: sourceSize)
        }
        
        let aspect = mutableSourceSize.width / mutableSourceSize.height
        // If only one dimension in destSize is non-zero (for example, an Image
        // with `flex: 1` whose height is indeterminate), calculate the unknown
        // dimension based on the aspect ratio of sourceSize
        if (targetSize.width == 0) {
            targetSize.width = targetSize.height * aspect
        }
        if (targetSize.height == 0) {
            targetSize.height = targetSize.width / aspect
        }
        
        
        // Calculate target aspect ratio if needed
        var targetAspect: CGFloat = 0.0
        var targetResizeMode = resizeMode
        if (targetResizeMode != .stretch) {
            targetAspect = targetSize.width / targetSize.height;
            if (aspect == targetAspect) {
                targetResizeMode = .stretch;
            }
        }
        
        switch (resizeMode) {
        case .stretch:
            return CGRect(origin: CGPoint.zero, size: scaleSize(targetSize, destScale))
        case .contain:
            
            if (targetAspect <= aspect) { // target is taller than content
                
                mutableSourceSize.width = targetSize.width;
                mutableSourceSize.height = mutableSourceSize.width / aspect;
                
            } else { // target is wider than content
                
                mutableSourceSize.height = targetSize.height;
                mutableSourceSize.width = mutableSourceSize.height * aspect;
            }
            
            return CGRect(origin: CGPoint(x: floor((targetSize.width - mutableSourceSize.width) / 2, destScale), y: floor((targetSize.height - mutableSourceSize.height) / 2, destScale)), size: scaleSize(mutableSourceSize, destScale))
        case .cover:

            if (targetAspect <= aspect) { // target is taller than content
                
                mutableSourceSize.height = targetSize.height;
                mutableSourceSize.width = mutableSourceSize.height * aspect;
                targetSize.width = destSize.height * targetAspect;
                
                return CGRect(origin: CGPoint(x: floor((mutableSourceSize.width - mutableSourceSize.width) / 2, destScale), y: 0), size: scaleSize(mutableSourceSize, destScale))
                
            } else { // target is wider than content
                
                mutableSourceSize.width = targetSize.width;
                mutableSourceSize.height = mutableSourceSize.width / aspect;
                targetSize.height = targetSize.width / targetAspect;
                
                return CGRect(origin: CGPoint(x: 0, y: floor((targetSize.height - mutableSourceSize.height) / 2, destScale)), size: scaleSize(mutableSourceSize, destScale))
            }
        }
    }
    
    static func scaleSize(_ size: CGSize, _ scale: CGFloat) -> CGSize {
        return CGSize(width: ceil(size.width, scale), height: ceil(size.height, scale))
    }
    
    static func floor(_ value: CGFloat, _ scale: CGFloat) -> CGFloat {
        return (value * scale).rounded(.down) / scale
    }
    
    static func ceil(_ value: CGFloat, _ scale: CGFloat) -> CGFloat {
        return (value * scale).rounded(.up) / scale
    }
}
