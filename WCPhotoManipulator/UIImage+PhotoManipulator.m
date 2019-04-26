//
//  UIImage+PhotoManipulator.m
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 23/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import "UIImage+PhotoManipulator.h"
#import "BitmapUtils.h"

@implementation UIImage (PhotoManipulator)

// Crop & Resize
- (UIImage *)crop:(CGRect)region {
    CGSize targetSize = region.size;
    CGRect targetRect = {{-region.origin.x, -region.origin.y}, self.size};
    CGAffineTransform transform = [BitmapUtils transformFromTargetRect:self.size targetRect:targetRect];
    
    return [BitmapUtils transform:self size:targetSize scale:self.scale transform:transform];
}

- (UIImage *)resize:(CGSize)targetSize scale:(CGFloat)scale {
    CGRect targetRect = [BitmapUtils targetRect:self.size destSize:targetSize destScale:1 resizeMode:ResizeModeContain];
    CGAffineTransform transform = [BitmapUtils transformFromTargetRect:self.size targetRect:targetRect];

    return [BitmapUtils transform:self size:targetSize scale:scale transform:transform];
}
- (UIImage *)crop:(CGRect)region targetSize:(CGSize)targetSize {
    return [[self crop:region] resize:targetSize scale:self.scale];
}

// Text
- (UIImage *)drawText:(NSString *)text position:(CGPoint)position color:(UIColor *)color size:(CGFloat)size thickness:(CGFloat)thickness scale:(CGFloat)scale {
    BOOL opaque = ![self hasAlpha];
    UIGraphicsBeginImageContextWithOptions(self.size, opaque, scale);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];

    NSMutableDictionary *textStyles = [NSMutableDictionary new];
    textStyles[NSFontAttributeName] = [UIFont systemFontOfSize:size];
    textStyles[NSForegroundColorAttributeName] = color;
    if (thickness > 0) {
        textStyles[NSStrokeColorAttributeName] = color;
        textStyles[NSStrokeWidthAttributeName] = @(thickness);
    }
    [text drawAtPoint:position withAttributes:textStyles];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
- (UIImage *)drawText:(NSString *)text position:(CGPoint)position color:(UIColor *)color size:(CGFloat)size thickness:(CGFloat)thickness {
    return [self drawText:text position:position color:color size:size thickness:thickness scale:self.scale];
}

// Overlay
- (UIImage *)overlayImage:(UIImage *)overlay position:(CGPoint)position scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(self.size, true, scale);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGRect overlayRect = { position, overlay.size };
    [overlay drawInRect:overlayRect];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
- (UIImage *)overlayImage:(UIImage *)overlay position:(CGPoint)position {
    return [self overlayImage:overlay position:position scale:self.scale];
}

// Helpers
- (BOOL)hasAlpha {
    switch (CGImageGetAlphaInfo(self.CGImage)) {
        case kCGImageAlphaNone:
        case kCGImageAlphaNoneSkipLast:
        case kCGImageAlphaNoneSkipFirst:
            return NO;
        default:
            return YES;
    }
}

@end
