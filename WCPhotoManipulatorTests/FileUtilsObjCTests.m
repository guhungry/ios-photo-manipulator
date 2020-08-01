//
//  FileUtilsObjCTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImage+Testing.h"
#import "WCPhotoManipulator-Swift.h"

@interface FileUtilsObjCTests : XCTestCase

@end

@interface FileUtils (Private)

+ (NSData *)imageToData:(UIImage *)image mimeType:(NSString *)mimeType quality:(CGFloat)quality;
+ (NSArray *)filesIn:(NSString *)path withPrefix:(NSString *)prefix;

@end

@implementation FileUtilsObjCTests {
    NSString *prefix;
    NSString *path;
    NSString *name;
    UIImage *image;
    NSData *data;
    NSURL *url;
    NSFileManager *fileManager;
}

- (void)setUp {
    fileManager = [NSFileManager defaultManager];
}

- (void)tearDown {
    prefix = nil;
    path = nil;
    name = nil;
    image = nil;
    data = nil;
    url = nil;
    fileManager = nil;
}


- (void)testCachePath_MustNotNil {
    path = [FileUtils cachePath];
    NSString *expected = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    XCTAssertNotNil(path);
    XCTAssert([path isEqualToString:expected]);
}

////////////////////////////
/// createTempFile
///////////////////////////
- (void)testCreateTempFile_WhenPNG_ShouldReturnFileWithPrefix {
    prefix = @"TEST_";
    path = [FileUtils createTempFile:prefix mimeType:MimeUtils.PNG];
    name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".png"]);
}

- (void)testCreateTempFile_WhenJPEG_ShouldReturnFileWithPrefix {
    prefix = @"JPG_";
    path = [FileUtils createTempFile:prefix mimeType:MimeUtils.JPEG];
    name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".jpg"]);
}

////////////////////////////
/// imageToData
///////////////////////////
- (void)testImageToData_WhenOuptutJpeg_ShouldReturnJpeg {
    image = [UIImage imageNamedTest:@"overlay.png"];
    data = [FileUtils imageToData:image mimeType:MimeUtils.JPEG quality:100];
    
    XCTAssertNotNil(data);
    XCTAssert([[self imageMimeType:data] isEqualToString:MimeUtils.JPEG]);
}

- (void)testImageToData_WhenOuptutPNG_ShouldReturnPng {
    image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    data = [FileUtils imageToData:image mimeType:MimeUtils.PNG quality:100];
    
    XCTAssertNotNil(data);
    XCTAssert([[self imageMimeType:data] isEqualToString:MimeUtils.PNG]);
}

////////////////////////////
/// imageFromUrl
///////////////////////////
- (void)testImageFromUrl_WhenLocalFile_ShouldHaveData {
    url = [[NSBundle bundleForClass:[self class]] URLForResource:@"overlay" withExtension:@"png"];
    
    image = [FileUtils imageFromUrl:url];
    XCTAssertNotNil(image);
}

- (void)testImageFromUrl_WhenUrl_ShouldHaveData {
    url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/200px-React-icon.svg.png"];
    
    image = [FileUtils imageFromUrl:url];
    XCTAssertNotNil(image);
}

////////////////////////////
/// saveImageFile
///////////////////////////
- (void)testSaveImageFile_WhenPNG_ShouldSavePNG {
    path = [FileUtils createTempFile:@"PNG_" mimeType:MimeUtils.PNG];
    image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    XCTAssertFalse([fileManager fileExistsAtPath:path]);
    
    [FileUtils saveImageFile:image mimeType:path quality:100 file:path];
    
    XCTAssertTrue([fileManager fileExistsAtPath:path]);
    
    NSDictionary<NSFileAttributeKey, id> *attributes = [fileManager attributesOfItemAtPath:path error:nil];
    XCTAssertNotNil(attributes);
    XCTAssertTrue([attributes fileSize] > 0);
    
    [fileManager removeItemAtPath:path error:nil];
}

- (void)testSaveImageFile_WhenJPEG_ShouldSaveJEPG {
    path = [FileUtils createTempFile:@"JPEG_" mimeType:MimeUtils.JPEG];
    image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    XCTAssertFalse([fileManager fileExistsAtPath:path]);
    
    [FileUtils saveImageFile:image mimeType:path quality:100 file:path];
    
    XCTAssertTrue([fileManager fileExistsAtPath:path]);
    
    NSDictionary<NSFileAttributeKey, id> *attributes = [fileManager attributesOfItemAtPath:path error:nil];
    XCTAssertNotNil(attributes);
    XCTAssertTrue([attributes fileSize] > 0);
    
    [fileManager removeItemAtPath:path error:nil];
}

////////////////////////////
/// cleanDirectory
///////////////////////////
- (void)testCleanDirectory {
    prefix = @"PREFIX_";
    data = [[NSData alloc] init];
    path = NSTemporaryDirectory();
    
    [fileManager createFileAtPath:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", prefix, @"bee1.png"]] contents:data attributes:nil];
    [fileManager createFileAtPath:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", prefix, @"bee2.png"]] contents:data attributes:nil];
    
    NSArray *files = [FileUtils filesIn:path withPrefix:prefix];
    XCTAssertEqual(files.count, 2);
    
    [FileUtils cleanDirectory:path prefix:prefix];
    
    files = [FileUtils filesIn:path withPrefix:prefix];
    XCTAssertEqual(files.count, 0);
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
