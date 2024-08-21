//
//  File.swift
//  
//
//  Created by Woraphot Chokratanasombat on 21/8/2567 BE.
//

import UIKit

extension CGBitmapInfo {
    enum ComponentLayout {
        case bgra
        case abgr
        case argb
        case rgba
        case bgr
        case rgb

        var count: Int {
            switch self {
            case .bgr, .rgb: return 3
            default: return 4
            }
        }
    }
/***
 
 
 var isAlphaFirst: Bool {
     let alphaInfo = cgImage?.alphaInfo
     return alphaInfo == .first || alphaInfo == .premultipliedFirst || alphaInfo == .noneSkipFirst
 }

 var isAlphaLast: Bool {
     let alphaInfo = cgImage?.alphaInfo
     return alphaInfo == .last || alphaInfo == .premultipliedLast || alphaInfo == .noneSkipLast
 }

 var isLittleEndian: Bool {
     let byteInfo = cgImage?.bitmapInfo
     return byteInfo == .byteOrder16Little || byteInfo == .byteOrder32Little
 }
 */
    var componentLayout: ComponentLayout? {
        guard let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & Self.alphaInfoMask.rawValue) else { return nil }
        let isLittleEndian = contains(.byteOrder32Little)

        if alphaInfo == .none {
            return isLittleEndian ? .bgr : .rgb
        }
        let alphaIsFirst = alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .noneSkipFirst

        if isLittleEndian {
            return alphaIsFirst ? .bgra : .abgr
        } else {
            return alphaIsFirst ? .argb : .rgba
        }
    }

    var chromaIsPremultipliedByAlpha: Bool {
        let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & Self.alphaInfoMask.rawValue)
        return alphaInfo == .premultipliedFirst || alphaInfo == .premultipliedLast
    }
}
