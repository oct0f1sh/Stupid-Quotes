//
//  UIView+RoundedCorners.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/9/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
