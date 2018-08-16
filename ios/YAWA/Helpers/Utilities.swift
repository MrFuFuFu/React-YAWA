//
//  Utilities.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

enum DayTime: String {
    case Overnight = "03:00"
    case Morning = "09:00"
    case Afternoon = "15:00"
    case Evening = "21:00"
}

extension UIView {
    func addShadow() {
        layer.shadowRadius = 8
        layer.masksToBounds = false
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
extension UIColor {
    /// making Hex color to rgb, so that can use to UIColor
    ///
    /// - Parameter fromHex: Hex color eg:#ffffff
    /// - Returns: UIColor
    class func rgb(fromHex: Int) -> UIColor
    {
        return UIColor.rgb(fromHex: fromHex, alpha: 1.0)
    }
    
    class func rgb(fromHex: Int, alpha: Float) -> UIColor
    {
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(alpha)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static let randomColor: [UIColor] = [UIColor.rgb(fromHex: 0xFF6565), UIColor.rgb(fromHex: 0xA065FF),
                  UIColor.rgb(fromHex: 0xFF659E), UIColor.rgb(fromHex: 0x86E99E),
                  UIColor.rgb(fromHex: 0x6D65FF), UIColor.rgb(fromHex: 0x6C6C6C)]
}

