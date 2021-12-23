//
//  Extensions.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/21/21.
//

import Foundation
import UIKit

extension UIColor {
    convenience init<T: BinaryInteger>(r: T, g: T, b: T, a: T = 255) {
        self.init(red: .init(r)/255, green: .init(g)/255, blue: .init(b)/255, alpha: .init(a)/255)
    }
}
