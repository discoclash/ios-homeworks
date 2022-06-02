//
//  UIViewExtensionID.swift
//  Navigation
//
//  Created by G on 19.05.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func shakeText() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
