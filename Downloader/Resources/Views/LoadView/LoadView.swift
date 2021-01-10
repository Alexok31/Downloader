//
//  ProgressView.swift
//  CircularProgress
//
//  Created by Zafar on 10/3/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class LoadView: UIButton {
    
    // MARK: - Properties
    var lineWidth: CGFloat = 5
    
    private var isAnimating: Bool = false
    private var colors: [UIColor] {
        return [R.color.loadBlue()!, R.color.loadRed()!,
                R.color.loadYelow()!, R.color.loadPurple()!, R.color.loadOrange()!]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn:
            CGRect(
                x: 0,
                y: 0,
                width: self.bounds.width,
                height: self.bounds.width
            )
        )
        
        shapeLayer.path = path.cgPath
    }
    
    func start() {
        guard !isAnimating else { return }
        self.animateStroke()
        self.animateRotation()
        isAnimating = true
    }
    
    func stop() {
        self.shapeLayer.removeFromSuperlayer()
        self.layer.removeAllAnimations()
        isAnimating = false
    }
    
    // MARK: - Animations
    private func animateStroke() {
        
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        
        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )

        shapeLayer.add(colorAnimation, forKey: nil)
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func animateRotation() {
        let rotationAnimation = RotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 2,
            repeatCount: .greatestFiniteMagnitude
        )
        
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
}
