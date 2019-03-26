//
//  FileUtils.h
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 24/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUtils : NSObject

+ (NSString *)createTempFile:(NSString *)prefix mimeType:(NSString *)mimeType;
+ (NSString *)cachePath;
+ (void)cleanDirectory:(NSString *)path prefix:(NSString *)prefix;
+ (void)saveImageFile:(UIImage *)image mimeType:(NSString *)mimeType quality:(CGFloat)quality file:(NSString *)file;
+ (UIImage *)imageFromUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
