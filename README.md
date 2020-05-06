# iOS Photo Manipulator
[![Build Status](https://travis-ci.com/guhungry/ios-photo-manipulator.svg?branch=master)](https://travis-ci.com/guhungry/ios-photo-manipulator)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=guhungry_ios-photo-manipulator&metric=alert_status)](https://sonarcloud.io/dashboard?id=guhungry_ios-photo-manipulator)
[![codecov](https://codecov.io/gh/guhungry/ios-photo-manipulator/branch/master/graph/badge.svg)](https://codecov.io/gh/guhungry/ios-photo-manipulator)
[![cocoapods](https://cocoapod-badges.herokuapp.com/v/WCPhotoManipulator/badge.png)](https://cocoapods.org/pods/WCPhotoManipulator)

Image processing library to edit image programmatically for iOS.
This library is used by [react-native-photo-manipulator](https://github.com/guhungry/react-native-photo-manipulator/).

## Installation
Add dependency `Podfile`

```rb
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Demo' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Add WCPhotoManipulator
  pod 'WCPhotoManipulator', :git => 'https://github.com/guhungry/ios-photo-manipulator.git', :tag => 'v1.0.0'

end
```

## Usage UIImage+PhotoManipulator

Import using
```objc
#import <WCPhotoManipulator/UIImage+PhotoManipulator.h>
```

### [image crop]
Crop image from specified `cropRegion`

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                               |
|------------|-----------------------|----------|-----------------------------------------------------------|
| cropRegion | CGRect                | Yes      | Region to be crop in CGRect(`x`, `y`, `size`, `width`)    |
| scale      | CGFloat               | No       | Scale of result image. Default = image.scale              |

### [image resize]
Resize image from specified into `targetSize` using resize mode `cover`

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                               |
|------------|-----------------------|----------|-----------------------------------------------------------|
| targetSize | CGSize                | Yes      | Size of result image                                      |
| scale      | CGFloat               | No       | Scale of result image. Default = image.scale              |

### [image drawText]
Print text into image

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                                            |
|------------|-----------------------|----------|------------------------------------------------------------------------|
| text       | NSString              | Yes      | Text to print in image                                                 |
| position   | CGPoint               | Yes      | Position to in in `x`, `y`                                             |
| color      | UIColor*              | Yes      | Text color                                                             |
| textSize   | CGFloat               | Yes      | Text size                                                              |
| thickness  | Float                 | No       | Outline of text. Default = 0                                           |
| scale      | CGFloat               | No       | Scale of result image. Default = image.scale                           |

### [image overlayImage]
Overlay image on top of background image

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                                            |
|------------|-----------------------|----------|------------------------------------------------------------------------|
| overlay    | UIImage*              | Yes      | Overlay image                                                          |
| position   | CGPoint               | Yes      | Position of overlay image in background image                          |


## Usage FileUtils

Import using
```objc
#import <WCPhotoManipulator/FileUtils.h>
```

### [FileUtils createTempFile]
Create temp file into cache directory with prefix

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                     |
|------------|-----------------------|----------|-------------------------------------------------|
| prefix     | NSString              | Yes      | Temp file name prefix                           |
| mimeType   | NSString              | Yes      | Mime type of image. Default = image/jpeg        |

### [FileUtils cachePath]
Get cache path of app

### [FileUtils cleanDirectory]
Delete all files in directory with prefix

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                     |
|------------|-----------------------|----------|-------------------------------------------------|
| directory  | NSString              | Yes      | Path to clean                                   |
| prefix     | NSString              | Yes      | File name prefix to match                       |


### [FileUtils saveImageFile]
Save image to target path

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                               |
|------------|-----------------------|----------|-----------------------------------------------------------|
| image      | UII mage              | Yes      | Source image                                              |
| mimeType   | NSString              | Yes      | Mime type of target file                                  |
| quality    | CGFloat               | Yes      | Quality of image between 0 - 1(For jpg only)              |
| file       | NSString              | Yes      | Target file path                                          |

### [FileUtils imageFromUrl]
Open file from uri as input stream

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                               |
|------------|-----------------------|----------|-----------------------------------------------------------|
| uri        | String                | Yes      | Uri of image can be remote (https?://) or local (file://) |


## Usage MimeUtils

Import using
```objc
#import <WCPhotoManipulator/FileUtils.h>
```

### [MimeUtils toExtension]
Get image file extension from mimeType (Support .jpg, .png and .webp)

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                     |
|------------|-----------------------|----------|-------------------------------------------------|
| mimeType   | String                | Yes      | Image mime type                                 |

