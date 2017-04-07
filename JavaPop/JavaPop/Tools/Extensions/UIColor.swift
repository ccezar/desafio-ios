//
//  UIColor.swift
//  JavaPop
//
//  Created by Caio on 07/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
    
    public convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, alphaValue: 1.0)
    }
    
    public convenience init(netHex: Int, alpha: CGFloat) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, alphaValue: alpha)
    }
    
    public class func fadeColor(from: UIColor, to: UIColor, percentage: CGFloat) -> UIColor {
        
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        
        from.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        to.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        //calculate the actual RGBA values of the fade colour
        let red = (toRed - fromRed) * percentage + fromRed
        let green = (toGreen - fromGreen) * percentage + fromGreen;
        let blue = (toBlue - fromBlue) * percentage + fromBlue;
        let alpha = (toAlpha - fromAlpha) * percentage + fromAlpha;
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
