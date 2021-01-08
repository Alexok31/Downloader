//
//  Extension+CALayer.swift
//  Downloader
//
//  Created by Alex Kharchenko on 08.01.2021.
//

import UIKit

extension CALayer {
    
    func applyShadow(
        color: UIColor = .clear,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func standartShadow(color: UIColor?) {
        self.applyShadow(color: color ?? .black, alpha: 0.5, x: 0, y: 5, blur: 15, spread: 0)
    }
}
