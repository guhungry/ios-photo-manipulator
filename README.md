# iOS Photo Manipulator
[![Build and Test](https://github.com/guhungry/ios-photo-manipulator/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/guhungry/ios-photo-manipulator/actions/workflows/build-and-test.yml)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=guhungry_ios-photo-manipulator&metric=alert_status)](https://sonarcloud.io/dashboard?id=guhungry_ios-photo-manipulator)
[![Cocoapods Version](https://img.shields.io/cocoapods/v/WCPhotoManipulator)](https://cocoapods.org/pods/WCPhotoManipulator)

iOS Image Processing API to edit photo programmatically.
This library is used by [react-native-photo-manipulator](https://github.com/guhungry/react-native-photo-manipulator/).

## Installation
### Using CocoaPods
Add dependency `Podfile`

```rb
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Demo' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Add WCPhotoManipulator
  pod 'WCPhotoManipulator', :git => 'https://github.com/guhungry/ios-photo-manipulator.git', :tag => 'v2.4.1'

end
```
or
### Using Swift Package Manager
Add dependency in `Package.swift`

```swift
    dependencies: [
        ...,
        .package(url: "https://github.com/guhungry/ios-photo-manipulator.git", from: "2.4.2"),
        ...,
    ],
```

## Usage
Import using
```objc
@import WCPhotoManipulator;
```

## Usage UIImage+PhotoManipulator

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
| font       | UIFont                | Yes      | Font to use                                                            |
| thickness  | Float                 | No       | Outline of text. Default = 0                                           |
| rotation   | Float                 | No       | Rotation angle in degrees                                              |
| scale      | CGFloat               | No       | Scale of result image. Default = image.scale                           |

### [image overlayImage]
Overlay image on top of background image

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                                            |
|------------|-----------------------|----------|------------------------------------------------------------------------|
| overlay    | UIImage*              | Yes      | Overlay image                                                          |
| position   | CGPoint               | Yes      | Position of overlay image in background image                          |

### [image flip]
Flip the image horizontally, vertically or both

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                                            |
|------------|-----------------------|----------|------------------------------------------------------------------------|
| mode       | FlipMode              | Yes      | Flip mode .Vertical or .Horizontal or .Both                            |

### [image rotate]
Rotate the image 90°, 180° or 270°

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                                            |
|------------|-----------------------|----------|------------------------------------------------------------------------|
| mode       | RotationMode          | Yes      | Rotation mode .R90 (90° Clockwise), .R180 (180° Half Rotation) or .R270 (270° Clockwise, aka 90° Counterclockwise)                            |


## Usage FileUtils

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

### [MimeUtils toExtension]
Get image file extension from mimeType (Support .jpg, .png and .webp)

| NAME       | TYPE                  | REQUIRED | DESCRIPTION                                     |
|------------|-----------------------|----------|-------------------------------------------------|
| mimeType   | String                | Yes      | Image mime type                                 |
