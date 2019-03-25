//
//  MimeUtils.h
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 25/3/19.
//  Copyright © 2019 Woraphot Chokratanasombat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MimeUtils : NSObject

+ (NSString *)PNG;
+ (NSString *)JPEG;

+ (NSString *)toExtension:(NSString *)mimeType;

@end

NS_ASSUME_NONNULL_END
