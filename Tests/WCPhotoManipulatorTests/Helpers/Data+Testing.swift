//
//  File.swift
//  
//
//  Created by Woraphot Chokratanasombat on 21/8/2567 BE.
//

import Foundation

extension Data {
    public func mimeType() -> String? {
        var c: UInt8 = 0;
        
        copyBytes(to: &c, count: 1)
        
        switch (c) {
        case 0xFF: return "image/jpeg"
        case 0x89: return "image/png"
        case 0x47: return "image/gif"
        case 0x49, 0x4D: return "image/tiff"
        default: return nil
        }
    }
}
