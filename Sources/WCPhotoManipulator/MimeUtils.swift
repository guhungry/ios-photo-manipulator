//
//  MimeUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//
import Foundation

@objc public class MimeUtils: NSObject {
    @objc public static let PNG = "image/png"
    @objc public static let JPEG = "image/jpeg"

    @objc public class func toExtension(_ type: String) -> String {
        if type == PNG {
            return ".png"
        }
        return ".jpg"
    }
}
