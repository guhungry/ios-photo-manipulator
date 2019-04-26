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
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@", prefix, [[NSUUID UUID] UUIDString], extension];
    return [FileUtils.cachePath stringByAppendingPathComponent:fileName];
}

+ (NSString *)cachePath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [array objectAtIndex:0];
}

+ (void)cleanDirectory:(NSString *)path prefix:(NSString *)prefix {
    NSArray *files = [FileUtils filesIn:path withPrefix:prefix];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [files enumerateObjectsUsingBlock:^(NSString *file, __unused NSUInteger idx, __unused BOOL *stop) {
        [fileManager removeItemAtPath:file error:nil];
    }];
}
+ (NSArray *)filesIn:(NSString *)path withPrefix:(NSString *)prefix {
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    files = [files filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", prefix]];
    
    NSMutableArray *result = [NSMutableArray array];
    [files enumerateObjectsUsingBlock:^(NSString *name, __unused NSUInteger idx, __unused BOOL *stop) {
        [result addObject:[path stringByAppendingPathComponent:name]];
    }];
    return result;
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
    if ([url.scheme isEqual:@"file"]) return [UIImage imageWithContentsOfFile:url.path];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

@end
