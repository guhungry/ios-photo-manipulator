//
//  UIImage+Testing.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 29/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import "UIImage+Testing.h"

@interface BundleLocator : NSObject
@end

@implementation BundleLocator
@end

@implementation UIImage (Testing)

+(UIImage *)imageNamedTest:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[BundleLocator class]];
    NSString *path = [bundle pathForResource:name.stringByDeletingPathExtension ofType:name.pathExtension];
    return [UIImage imageWithContentsOfFile:path];
}

-(BOOL)isAlphaFirst {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    return alphaInfo == kCGImageAlphaFirst || alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaNoneSkipFirst;
}

-(BOOL)isAlphaLast {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    return alphaInfo == kCGImageAlphaLast || alphaInfo == kCGImageAlphaPremultipliedLast || alphaInfo == kCGImageAlphaNoneSkipLast;
}

-(BOOL)isLittleEndian {
    CGImageByteOrderInfo byteInfo = CGImageGetByteOrderInfo(self.CGImage);
    return byteInfo == kCGImageByteOrder16Little || byteInfo == kCGImageByteOrder32Little;
}

-(UIColor*)colorAt:(CGPoint)location {
    NSInteger width = CGImageGetWidth(self.CGImage);
    NSInteger components = CGImageGetBitsPerPixel(self.CGImage) / CGImageGetBitsPerComponent(self.CGImage);
    
    const UInt8 *data = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage)));
    
    NSInteger index = ((width * location.y) + location.x) * components;
    
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 1;
    
    switch (components) {
        case 1:
            a = data[index] / 255.0;
            break;
            
        case 3:
            if ([self isLittleEndian]) {
                r = data[index + 2] / 255.0;
                g = data[index + 1] / 255.0;
                b = data[index] / 255.0;
            } else {
                r = data[index] / 255.0;
                g = data[index + 1] / 255.0;
                b = data[index + 2] / 255.0;
            }
            break;
            
        case 4:
            if ([self isAlphaFirst] && [self isLittleEndian]) {
                r = data[index + 2] / 255.0;
                g = data[index + 1] / 255.0;
                b = data[index] / 255.0;
                a = data[index + 3] / 255.0;
            } else if ([self isAlphaFirst]) {
                r = data[index + 1] / 255.0;
                g = data[index + 2] / 255.0;
                b = data[index + 3] / 255.0;
                a = data[index] / 255.0;
            } else if ([self isAlphaLast] && [self isLittleEndian]) {
                r = data[index + 3] / 255.0;
                g = data[index + 2] / 255.0;
                b = data[index + 1] / 255.0;
                a = data[index] / 255.0;
            } else if ([self isAlphaLast]) {
                r = data[index] / 255.0;
                g = data[index + 1] / 255.0;
                b = data[index + 2] / 255.0;
                a = data[index + 3] / 255.0;
            }
            break;
            
        default:
            return UIColor.clearColor;
    }
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
