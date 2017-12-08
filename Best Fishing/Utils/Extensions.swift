//
//  Extensions.swift
//  Best Fishing
//
//  Created by Tom on 2017/10/18.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public class func fromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

