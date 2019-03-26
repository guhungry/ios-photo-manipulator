//
//  FileUtils.m
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 24/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import "FileUtils.h"
#import "MimeUtils.h"

@implementation FileUtils

+ (NSString *)createTempFile:(NSString *)prefix mimeType:(NSString *)mimeType {
    NSString *extension = [MimeUtils toExtension:mimeType];
    NSString *fileName = [[[NSUUID UUID] UUIDString] stringByAppendingString:extension];
    return [FileUtils.cachePath stringByAppendingPathComponent:fileName];
}

+ (NSString *)cachePath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [array objectAtIndex:0];
}

+ (void)cleanDirectory:(NSString *)path prefix:(NSString *)prefix {
    
}

+ (void)saveImageFile:(UIImage *)image mimeType:(NSString *)mimeType quality:(CGFloat)quality file:(NSString *)file {
    NSData *data = [FileUtils imageToData:image mimeType:mimeType quality:quality];
    
    [data writeToFile:file atomically:YES];
}

+ (NSData *)imageToData:(UIImage *)image mimeType:(NSString *)mimeType quality:(CGFloat)quality {
    if ([MimeUtils.PNG isEqual:mimeType]) return UIImagePNGRepresentation(image);
    else return UIImageJPEGRepresentation(image, quality / 100);
}

+ (UIImage *)imageFromUrl:(NSURL *)url {
    if ([url.scheme isEqual:@"file"]) return [UIImage imageWithContentsOfFile:url.absoluteString];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

@end
