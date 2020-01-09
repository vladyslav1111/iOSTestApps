//
//  CardView.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/9/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class CardView: UIView {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    private var dismissXValue: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -private functions
fileprivate extension CardView {
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }
    
    func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y).rotated(by: translation.x/frame.size.width/3)
    }
    
    func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let direction: CGFloat = gesture.translation(in: nil).x > dismissXValue ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > dismissXValue
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {[unowned self] in
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * direction, y: 0, width: self.superview!.frame.size.width, height: self.superview!.frame.size.height)
            } else {
                self.transform = .identity
            }
        }) { [unowned self] (_) in
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.size.width, height: self.superview!.frame.size.height)
        }
    }
}
