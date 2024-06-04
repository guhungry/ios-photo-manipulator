//
//  RotationMode.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 2/6/2567 BE.
//  Copyright © 2567 BE Woraphot Chokratanasombat. All rights reserved.
//

import Foundation
import UIKit

@objc public enum RotationMode: Int {
    case None = 0, R90 = 90, R180 = 180, R270 = 270
    
    func transform() -> CGAffineTransform {
        if (self == .None) { return CGAffineTransformIdentity }
        
        return CGAffineTransformMakeRotation(-CGFloat(self.rawValue) * CGFloat.pi / 180.0)
     }
}
