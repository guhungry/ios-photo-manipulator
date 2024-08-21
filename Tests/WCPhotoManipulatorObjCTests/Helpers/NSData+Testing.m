//
//  NSData+Testing.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 1/8/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

#import "NSData+Testing.h"

@implementation  NSData (Testing)

-(NSString *)mimeType {
    uint8_t c;
    [self getBytes:&c length:1];
    
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
