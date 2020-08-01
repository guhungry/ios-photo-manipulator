//
//  UIImage+Testing.h
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 29/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCPhotoManipulator-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Testing)

+(UIImage*)imageNamedTest:(NSString *)name;
-(UIColor*)colorAt:(CGPoint)location;

@end

NS_ASSUME_NONNULL_END
