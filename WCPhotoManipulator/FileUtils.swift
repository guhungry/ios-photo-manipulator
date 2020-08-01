//
//  FileUtils.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 28/7/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import Foundation
import UIKit

@objc public class FileUtils: NSObject {
    @objc public class func createTempFile(_ prefix: String, mimeType: String) -> String {
        let ext = MimeUtils.toExtension(mimeType)
        let filename = "\(prefix)\(UUID().uuidString)\(ext)"
        return (cachePath() as NSString).appendingPathComponent(filename)
    }
    
    @objc public class func cachePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
    
    @objc public class func cleanDirectory(_ path: String, prefix: String) {
        let fileManager = FileManager.default
        
        filesIn(path, withPrefix: prefix).forEach { it in
            try? fileManager.removeItem(atPath: it)
        }
    }
    
    @objc internal class func filesIn(_ path: String, withPrefix prefix: String) -> [String] {
        return (try? FileManager.default
            .contentsOfDirectory(atPath: path)
            .filter({it in it.starts(with: prefix)})
            .map({it in (path as NSString).appendingPathComponent(it)}))
        ?? []
    }
    
    @objc public class func saveImageFile(_ image: UIImage, mimeType: String, quality: CGFloat, file: String) {
        let data = imageToData(image, mimeType:mimeType, quality:quality)
        
        try? data?.write(to: URL(fileURLWithPath: file), options: .atomic)
    }

    @objc public class func imageFromUrl(_ url: URL) -> UIImage? {
        if url.scheme == "file" {
            return UIImage(contentsOfFile: url.path)
        }
        return UIImage(data: try! Data(contentsOf: url))
    }

    @objc internal class func imageToData(_ image: UIImage, mimeType: String, quality: CGFloat) -> Data? {
        if (MimeUtils.PNG == mimeType) {
            return image.pngData()
        }
        return image.jpegData(compressionQuality: quality / 100)
    }
}
