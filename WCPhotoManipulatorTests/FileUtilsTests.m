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

@implementation FileUtilsTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testCachePath_MustNotNil {
    NSString *path = [FileUtils cachePath];
    
    XCTAssertNotNil(path);
}

- (void)testCreateTempFile_ShouldReturnFileWithPrefix {
    NSString *prefix = @"TEST_";
    NSString *path = [FileUtils createTempFile:prefix mimeType:@"image/jpeg"];
    NSString *name = [path lastPathComponent];
    
    XCTAssertNotNil(path);
    XCTAssertTrue([path hasPrefix:[FileUtils cachePath]]);
    XCTAssertTrue([name hasPrefix:prefix]);
    XCTAssertTrue([name hasSuffix:@".png"]);
}

@end
