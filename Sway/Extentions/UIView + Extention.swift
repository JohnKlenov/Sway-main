//
//  UIView + Extention.swift
//  Sway
//
//  Created by Omar Ahmed on 13/06/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func setUp(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func setGradient(withColors colors: [CGColor] , startPoint: CGPoint , endPoint: CGPoint) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
}



struct windowConstant {
    
    private static let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    static var getTopPadding: CGFloat {
        print("window?.safeAreaInsets.top - \(String(describing: window?.safeAreaInsets.top))")
        print("window?.safeAreaInsets.top - \(String(describing: window?.safeAreaInsets.left))")
        return window?.safeAreaInsets.top ?? 0
    }
    
    static var getBottomPadding: CGFloat {
        print("window?.safeAreaInsets.bottom  - \(String(describing: window?.safeAreaInsets.bottom))")
        return window?.safeAreaInsets.bottom ?? 0
    }
    
}
