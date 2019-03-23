//
//  UIImage+PhotoManipulator.h
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 23/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <UIkit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (PhotoManipulator)

// Crop & Resize
- (UIImage *)crop:(CGRect)region;
- (UIImage *)resize:(CGSize)targetSize scale:(CGFloat)scale;
- (UIImage *)crop:(CGRect)region targetSize:(CGSize)targetSize;

// Text
- (UIImage *)drawText:(NSString *)text position:(CGPoint)position color:(UIColor *)color size:(CGFloat)size thickness:(CGFloat)thickness scale:(CGFloat)scale;
- (UIImage *)drawText:(NSString *)text position:(CGPoint)position color:(UIColor *)color size:(CGFloat)size thickness:(CGFloat)thickness;

// Overlay
- (UIImage *)overlayImage:(UIImage *)overlay position:(CGPoint)position scale:(CGFloat)scale;
- (UIImage *)overlayImage:(UIImage *)overlay position:(CGPoint)position;

// Helpers
- (BOOL)hasAlpha;
@end

NS_ASSUME_NONNULL_END
