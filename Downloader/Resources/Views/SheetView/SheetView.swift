//
//  SheetView.swift
//  Arterium-ios
//
//  Created by Alex Kharchenko on 29.12.2020.
//

import UIKit

class SheetView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    
    var content: UIView?
    var openComplition: ((Bool) -> ())?
    
    private var darkBackground: UIView?
    private var topConstraint: NSLayoutConstraint?
    
    private var isDarkBackground = Bool()
    private var isOpen = Bool()
    private var bottomPosition: CGFloat = 0
    private var topPosition: CGFloat = 0
    private var currentPosition: CGFloat = 0
    private var animationDuration = 0.5
    
    override func awakeFromNib() {
        
        configUI()
    }
    
    func setupConstraintFromSuperview(content: UIView, height: CGFloat, isDarkBackground: Bool) {
        guard let superview = superview else { return }
        self.isDarkBackground = isDarkBackground

        content.frame = contentView.frame
        contentView.addSubview(content)
        self.content = content
        
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        topConstraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: 0)
        topConstraint?.isActive = true
        
        guard isDarkBackground else { return }
        darkBackground = UIView()
        darkBackground?.frame = superview.frame
        darkBackground?.backgroundColor = .black
        darkBackground?.alpha = 0
        darkBackground?.isHidden = true
        superview.addSubview(darkBackground!)
        superview.bringSubviewToFront(self)
    }
    
    func configure(bottomPosition: CGFloat, topPosition: CGFloat, animationDuration: Double = 0.5) {
        self.bottomPosition = bottomPosition
        self.topPosition = topPosition
        self.animationDuration = animationDuration
        changeTopConstraint(constant: bottomPosition)
        currentPosition = bottomPosition
        isOpen = false
    }
    
    func open() {
        isOpen = true
        openComplition?(isOpen)
        changeTopConstraint(constant: topPosition, animation: true)
        currentPosition = topPosition
        self.darkBackground?.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.darkBackground?.alpha = 0.3
        }
    }
    
    func clouse() {
        isOpen = false
        openComplition?(isOpen)
        changeTopConstraint(constant: bottomPosition, animation: true)
        currentPosition = bottomPosition
        UIView.animate(withDuration: 0.3) {
            self.darkBackground?.alpha = 0
        } completion: { (_) in
            self.darkBackground?.isHidden = true
        }

    }
}

// MARK: - Private methods
extension SheetView {
    private func configUI() {
        layer.cornerRadius = 16
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc private func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let pointY = sender.translation(in: self).y
            let value = currentPosition + pointY
            if value >= topPosition, value <= bottomPosition {
                changeTopConstraint(constant: value, animation: true)
            }
        case .ended:
            setCurrentPositionByConstraint()
            openingControl()
            closingСontrol()
        default:
            break
        }
    }
    
    private func openingControl() {
        guard !isOpen else { return }
        if currentPosition < bottomPosition - 60 {
            // move to top
            open()
            currentPosition = topPosition
        } else {
            clouse()
            currentPosition = bottomPosition
        }
    }
    
    private func closingСontrol() {
        guard isOpen else { return }
        if currentPosition > topPosition + 60 {
            // move to bottom
            clouse()
            currentPosition = bottomPosition
        } else {
            open()
            currentPosition = topPosition
        }
    }
    
    private func changeTopConstraint(constant: CGFloat, animation: Bool = false) {
        guard let topConstraint = topConstraint, let superview = superview else { return }
        guard animation else {
            topConstraint.constant = constant
            superview.layoutIfNeeded()
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                topConstraint.constant = constant
                superview.layoutIfNeeded()
            })
        }
    }
    
    private func setCurrentPositionByConstraint() {
        guard let topConstraint = topConstraint else { return }
        currentPosition = topConstraint.constant
    }
    
}
