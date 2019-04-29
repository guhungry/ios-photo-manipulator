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

@end
