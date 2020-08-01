//
//  MimeUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//
import Foundation

@objc public class MimeUtils: NSObject {
    @objc public class func PNG() -> String {
        return "image/png"
    }
    @objc public class func JPEG() -> String {
        return "image/jpeg"
    }
    @objc public class func toExtension(_ type: String) -> String {
        if type == PNG() {
            return ".png"
        }
        return ".jpg"
    }
}
