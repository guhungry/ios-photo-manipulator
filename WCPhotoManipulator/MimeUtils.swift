//
//  MimeUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//
import Foundation

@objc public class MimeUtils: NSObject {
    @objc class func PNG() -> String {
        return "image/png"
    }
    @objc class func JPEG() -> String {
        return "image/jpeg"
    }
    @objc class func toExtension(_ type: String) -> String {
        if type == PNG() {
            return ".png"
        }
        return ".jpg"
    }
}
