//
//  UIImage+PhotoManipulator.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 22/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     Crop image
     
     - Parameter cropRegion: Position and Size of Image to crop
     
     - Returns: Cropped image
     */
    func crop(_ cropRegion: CGRect) -> UIImage? {
        let targetSize = cropRegion.size;
        let targetRect = CGRect(x: -cropRegion.origin.x, y: -cropRegion.origin.y, width: self.size.width, height: self.size.width)
        let operation = BitmapUtils.transformFromTargetRect(self.size, targetRect)
        
        return BitmapUtils.transform(self, targetSize, self.scale, operation)
    }
    
    /**
     Resize image to targetSize
     
     - Parameter targetSize: Target Image Size
     - Parameter scale: Scale of result image
     
     - Returns: Resized image
     */
    func resize(_ targetSize: CGSize, _ scale: CGFloat? = nil) -> UIImage? {
        let rect = BitmapUtils.targetRect(self.size, targetSize, 1, .cover)
        let operation = BitmapUtils.transformFromTargetRect(self.size, rect)
        return BitmapUtils.transform(self, targetSize, scale ?? self.scale, operation)
    }
    
    /**
     Crop and resize image
     
     - Parameter cropRegion: Position and Size of Image to crop
     - Parameter targetSize: Target Image Size
     
     - Returns: Cropped and resized image
     */
    func crop(_ cropRegion: CGRect, _ targetSize: CGSize) -> UIImage? {
        return self.crop(cropRegion)?.resize(targetSize, self.scale)
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
