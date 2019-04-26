//
//  BitmapUtils.h
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 23/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResizeMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface BitmapUtils : NSObject

+ (UIImage *)transform:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale transform:(CGAffineTransform)transform;
+ (CGAffineTransform)transformFromTargetRect:(CGSize)sourceSize targetRect:(CGRect)targetRect;
+ (CGRect)targetRect:(CGSize)sourceSize destSize:(CGSize)destSize destScale:(CGFloat)destScale resizeMode:(ResizeMode)resizeMode;

// CGFloat
+ (CGFloat)ceil:(CGFloat)value scale:(CGFloat)scale;
+ (CGFloat)floor:(CGFloat)value scale:(CGFloat)scale;

// CGSize
+ (CGSize)ceilSize:(CGSize)size scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
