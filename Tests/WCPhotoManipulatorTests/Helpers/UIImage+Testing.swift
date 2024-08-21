//
//  File.swift
//  
//
//  Created by Woraphot Chokratanasombat on 21/8/2567 BE.
//

import UIKit

extension UIImage {
    public convenience init?(namedTest name: String) {
        self.init(contentsOfFile: Self.urlImageNamedTest(name) ?? "")
    }
    
    static func urlImageNamedTest(_ name: String) -> String? {
        guard let name = name as NSString? else {
            return nil
        }
        return bundle()?.path(forResource: name.deletingPathExtension, ofType: name.pathExtension)
    }

    static func bundle() -> Bundle? {
        guard let url = Bundle(for: BundleLocator.self).resourceURL?.appendingPathComponent("WCPhotoManipulator_WCPhotoManipulatorTests.bundle") else {
            return nil
        }
        return Bundle(url: url)
    }

    fileprivate func isHDR(_ space: CGColorSpace) -> Bool {
        if #available(iOS 14.0, *) {
            return CGColorSpaceUsesITUR_2100TF(space)
        } else {
            return false
        }
    }
    
    func color(at point: CGPoint) -> UIColor? {
        guard
          let cgImage = cgImage,
          let space = cgImage.colorSpace,
          let pixelData = cgImage.dataProvider?.data,
          let layout = cgImage.bitmapInfo.componentLayout
        else {
          return nil
        }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let comp = CGFloat(layout.count)
        let isHDR = isHDR(space)
        let hdr = CGFloat(isHDR ? 2 : 1)
        let pixelInfo = Int((size.width * point.y * scale + point.x * scale) * comp * hdr)
        let i = Array(0 ... Int(comp - 1)).map {
          CGFloat(data[pixelInfo + $0 * Int(hdr)]) / CGFloat(255)
        }

        switch layout {
        case .bgra:
          return UIColor(red: i[2], green: i[1], blue: i[0], alpha: i[3])
        case .abgr:
          return UIColor(red: i[3], green: i[2], blue: i[1], alpha: i[0])
        case .argb:
          return UIColor(red: i[1], green: i[2], blue: i[3], alpha: i[0])
        case .rgba:
          return UIColor(red: i[0], green: i[1], blue: i[2], alpha: i[3])
        case .bgr:
          return UIColor(red: i[2], green: i[1], blue: i[0], alpha: 1)
        case .rgb:
          return UIColor(red: i[0], green: i[1], blue: i[2], alpha: 1)
        }
    }
}

class BundleLocator {}
