//
//  FlipMode.swift
//  WCPhotoManipulator
//
//  Created by Woraphot Chokratanasombat on 26/3/2567 BE.
//  Copyright © 2567 BE Woraphot Chokratanasombat. All rights reserved.
//

import Foundation
import UIKit

@objc public enum FlipMode: Int {
    case Horizontal, Vertical

    func transform() -> CGAffineTransform {
        switch self {
        case .Horizontal:
            return CGAffineTransformMakeScale(-1, 1)
        case .Vertical:
            return CGAffineTransformMakeScale(1, -1)
        }
     }
}
