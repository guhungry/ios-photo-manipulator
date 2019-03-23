#
#  Be sure to run `pod spec lint WCPhotoManipulator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "WCPhotoManipulator"
  s.version      = "0.0.3"
  s.summary  = "An image processing library for iOS"
  s.homepage     = "https://github.com/guhungry/ios-photo-manipulator"

  s.license      = "MIT"
  s.author       = { "Woraphot Chokratanasombat" => "guhungry@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/guhungry/ios-photo-manipulator.git", :tag => "#{s.version}" }
  s.source_files  = "WCPhotoManipulator/**/*.swift"

  s.swift_version = "4.2"
end
