//
//  UIColor+Extension.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    
    static var primary: UIColor {
        .init(red: 31, green: 31, blue: 31)
    }
    
    static var secondary: UIColor {
        .init(red: 36, green: 43, blue: 53)
    }
}
