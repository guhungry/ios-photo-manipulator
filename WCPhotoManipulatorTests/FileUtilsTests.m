//
//  FileUtilsTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FileUtils.h"

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

- (void)testCreateTempFile_ShouldReturnFileWithPrefix {
    NSString *prefix = @"TEST_";
    NSString *path = [FileUtils createTempFile:prefix mimeType:@"image/jpeg"];
    NSString *name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".png"]);
    
    prefix = nil;
    path = nil;
    name = nil;
}

- (void)testImageToData_WhenOuptutJpeg_ShouldReturnJpeg {
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSData *data = [FileUtils imageToData:image mimeType:@"image/jpeg" quality:100];
    
    XCTAssertNotNil(data);
    XCTAssertEqual([self imageMimeType:data], @"image/jpeg");
    
    image = nil;
    data = nil;
}

- (void)testImageToData_WhenOuptutJpeg_ShouldReturnPng {
    UIImage *image = [UIImage imageNamed:@"overlay" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    NSData *data = [FileUtils imageToData:image mimeType:@"image/png" quality:100];
    
    XCTAssertNotNil(data);
    XCTAssertEqual([self imageMimeType:data], @"image/png");
    
    image = nil;
    data = nil;
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

