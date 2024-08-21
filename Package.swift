// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WCPhotoManipulator",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "WCPhotoManipulator",
            targets: ["WCPhotoManipulator"]),
    ],
    targets: [
        .target(
            name: "WCPhotoManipulator"),
        .testTarget(
            name: "WCPhotoManipulatorTests",
            dependencies: ["WCPhotoManipulator"],
            resources: [.copy("Resources/background.jpg"),
                        .copy("Resources/overlay.png")]
        ),
        .testTarget(
            name: "WCPhotoManipulatorObjCTests",
            dependencies: ["WCPhotoManipulator"],
            resources: [.copy("Resources/background.jpg"),
                        .copy("Resources/overlay.png")]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
