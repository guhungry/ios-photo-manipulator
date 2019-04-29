//
//  BitmapUtils.m
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 23/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import "BitmapUtils.h"
#import "UIImage+PhotoManipulator.h"

@implementation BitmapUtils

+ (UIImage *)transform:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale transform:(CGAffineTransform)transform {
    if (size.width <= 0 | size.height <= 0 || scale <= 0) {
        return nil;
    }
    
    BOOL opaque = ![image hasAlpha];
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(currentContext, transform);
    [image drawAtPoint:CGPointZero];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (CGAffineTransform)transformFromTargetRect:(CGSize)sourceSize targetRect:(CGRect)targetRect {
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                           targetRect.origin.x,
                                           targetRect.origin.y);
    transform = CGAffineTransformScale(transform,
                                       targetRect.size.width / sourceSize.width,
                                       targetRect.size.height / sourceSize.height);
    return transform;
}

+ (CGRect)targetRect:(CGSize)sourceSize destSize:(CGSize)destSize destScale:(CGFloat)destScale resizeMode:(ResizeMode)resizeMode {
    
    if (CGSizeEqualToSize(destSize, CGSizeZero)) {
        // Assume we require the largest size available
        return (CGRect){CGPointZero, sourceSize};
    }
    
    CGFloat aspect = sourceSize.width / sourceSize.height;
    // If only one dimension in destSize is non-zero (for example, an Image
    // with `flex: 1` whose height is indeterminate), calculate the unknown
    // dimension based on the aspect ratio of sourceSize
    if (destSize.width == 0) {
        destSize.width = destSize.height * aspect;
    }
    if (destSize.height == 0) {
        destSize.height = destSize.width / aspect;
    }
    
    // Calculate target aspect ratio if needed
    CGFloat targetAspect = 0.0;
    if (resizeMode != ResizeModeStretch) {
        targetAspect = destSize.width / destSize.height;
        if (aspect == targetAspect) {
            resizeMode = ResizeModeStretch;
        }
    }
    
    switch (resizeMode) {
        case ResizeModeContain:
            
            if (targetAspect <= aspect) { // target is taller than content
                
                sourceSize.width = destSize.width;
                sourceSize.height = sourceSize.width / aspect;
            } else { // target is wider than content
                
                sourceSize.height = destSize.height;
                sourceSize.width = sourceSize.height * aspect;
            }
            return (CGRect){
                {
                    [BitmapUtils floor:((destSize.width - sourceSize.width) / 2) scale:destScale],
                    [BitmapUtils floor:((destSize.height - sourceSize.height) / 2) scale:destScale],
                },
                [BitmapUtils ceilSize:sourceSize scale:destScale]
            };
            
        case ResizeModeCover:
            
            if (targetAspect <= aspect) { // target is taller than content
                
                sourceSize.height = destSize.height;
                sourceSize.width = sourceSize.height * aspect;
                destSize.width = destSize.height * targetAspect;
                return (CGRect){
                    {[BitmapUtils floor:((destSize.width - sourceSize.width) / 2) scale:destScale], 0},
                    [BitmapUtils ceilSize:sourceSize scale:destScale]
                };
            }
            
            // target is wider than content
            sourceSize.width = destSize.width;
            sourceSize.height = sourceSize.width / aspect;
            destSize.height = destSize.width / targetAspect;
            return (CGRect){
                {0, [BitmapUtils floor:((destSize.height - sourceSize.height) / 2) scale:destScale]},
                [BitmapUtils ceilSize:sourceSize scale:destScale]
            };

        default: // ResizeModeStretch

            return (CGRect){CGPointZero, [BitmapUtils ceilSize:destSize scale:destScale]};
    }
}

// CGFloat
+ (CGFloat)ceil:(CGFloat)value scale:(CGFloat)scale {
    return ceil(value * scale) / scale;
}

+ (CGFloat)floor:(CGFloat)value scale:(CGFloat)scale {
    return floor(value * scale) / scale;
}

// CGSize
+ (CGSize)ceilSize:(CGSize)size scale:(CGFloat)scale {
    return CGSizeMake([BitmapUtils ceil:size.width scale:scale], [BitmapUtils ceil:size.height scale:scale]);
}
@end
