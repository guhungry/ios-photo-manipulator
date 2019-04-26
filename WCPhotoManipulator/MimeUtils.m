//
//  MimeUtils.m
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 25/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import "MimeUtils.h"

@implementation MimeUtils

+ (NSString *)PNG {
    return @"image/png";
}

+ (NSString *)JPEG {
    return @"image/jpeg";
}

+ (NSString *)toExtension:(NSString *)type {
    if ([type isEqual:MimeUtils.PNG]) return @".png";
    else return @".jpg";
}

@end
