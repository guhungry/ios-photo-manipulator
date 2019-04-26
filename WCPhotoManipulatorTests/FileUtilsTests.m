//
//  FileUtilsTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FileUtils.h"
#import "MimeUtils.h"

@interface FileUtilsTests : XCTestCase

@end

@interface FileUtils (Private)

+ (NSData *)imageToData:(UIImage *)image mimeType:(NSString *)mimeType quality:(CGFloat)quality;

@end

@implementation FileUtilsTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testCachePath_MustNotNil {
    NSString *path = [FileUtils cachePath];
    
    XCTAssertNotNil(path);
    
    path = nil;
}

- (void)testCreateTempFile_WhenPNG_ShouldReturnFileWithPrefix {
    NSString *prefix = @"TEST_";
    NSString *path = [FileUtils createTempFile:prefix mimeType:MimeUtils.PNG];
    NSString *name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".png"]);
    
    prefix = nil;
    path = nil;
    name = nil;
}

- (void)testCreateTempFile_WhenJPEG_ShouldReturnFileWithPrefix {
    NSString *prefix = @"JPG_";
    NSString *path = [FileUtils createTempFile:prefix mimeType:MimeUtils.JPEG];
    NSString *name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".jpg"]);
    
    prefix = nil;
    path = nil;
    name = nil;
}

- (void)testImageToData_WhenOuptutJpeg_ShouldReturnJpeg {
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSData *data = [FileUtils imageToData:image mimeType:MimeUtils.JPEG quality:100];
    
    XCTAssertNotNil(data);
    XCTAssertEqual([self imageMimeType:data], MimeUtils.JPEG);
    
    image = nil;
    data = nil;
}

- (void)testImageToData_WhenOuptutPNG_ShouldReturnPng {
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSData *data = [FileUtils imageToData:image mimeType:MimeUtils.PNG quality:100];
    
    XCTAssertNotNil(data);
    XCTAssertEqual([self imageMimeType:data], MimeUtils.PNG);
    
    image = nil;
    data = nil;
}

- (void)testImageFromUrl_WhenLocalFile_ShouldHaveData {
    NSURL *path = [[NSBundle bundleForClass:[self class]] URLForResource:@"overlay" withExtension:@"png"];
    
    UIImage *image = [FileUtils imageFromUrl:path];
    XCTAssertNotNil(image);
    
    path = nil;
    image = nil;
}

- (void)testImageFromUrl_WhenUrl_ShouldHaveData {
    NSURL *path = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/200px-React-icon.svg.png"];
    
    UIImage *image = [FileUtils imageFromUrl:path];
    XCTAssertNotNil(image);
    
    path = nil;
    image = nil;
}

- (void)testSaveImageFile_WhenPNG_ShouldSavePNG {
    NSString *path = [FileUtils createTempFile:@"PNG_" mimeType:MimeUtils.PNG];
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    XCTAssertFalse([fileManager fileExistsAtPath:path]);
    
    [FileUtils saveImageFile:image mimeType:path quality:100 file:path];
    
    XCTAssertTrue([fileManager fileExistsAtPath:path]);
    
    NSDictionary<NSFileAttributeKey, id> *attributes = [fileManager attributesOfItemAtPath:path error:nil];
    XCTAssertNotNil(attributes);
    XCTAssertTrue([attributes fileSize] > 0);
    
    [fileManager removeItemAtPath:path error:nil];
    
    path = nil;
    image = nil;
    fileManager = nil;
}

- (void)testSaveImageFile_WhenJPEG_ShouldSaveJEPG {
    NSString *path = [FileUtils createTempFile:@"JPEG_" mimeType:MimeUtils.JPEG];
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    XCTAssertFalse([fileManager fileExistsAtPath:path]);
    
    [FileUtils saveImageFile:image mimeType:path quality:100 file:path];
    
    XCTAssertTrue([fileManager fileExistsAtPath:path]);
    
    NSDictionary<NSFileAttributeKey, id> *attributes = [fileManager attributesOfItemAtPath:path error:nil];
    XCTAssertNotNil(attributes);
    XCTAssertTrue([attributes fileSize] > 0);
    
    [fileManager removeItemAtPath:path error:nil];
    
    path = nil;
    image = nil;
    fileManager = nil;
}

- (NSString *)imageMimeType:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end

