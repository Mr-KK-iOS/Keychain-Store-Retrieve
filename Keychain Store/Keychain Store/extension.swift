//
//  extension.swift
//  Keychain Store
//
//  Created by Admin on 10/13/20.
//  Copyright © 2020 Kaustabh. All rights reserved.
//

import Foundation

import UIKit

extension UIButton {
    func roundCorners(corners: UIRectCorner, radius: Int = 8) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
