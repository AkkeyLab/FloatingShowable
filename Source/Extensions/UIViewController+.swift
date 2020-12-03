//
//  UIViewController+.swift
//  FloatingShowable
//
//  Created by AKIO ITAYA on 2020/11/26.
//

import UIKit

public extension FloatingShowable {
    var stayArea: UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 16, right: 8)
    }

    var cornerRadius: CGFloat {
        12
    }

    var shadowColor: CGColor {
        UIColor.black.cgColor
    }

    var shadowOpacity: Float {
        0.15
    }

    var shadowOffset: CGSize {
        CGSize(width: .zero, height: 1)
    }

    var shadowRadius: CGFloat {
        6
    }

    var transitionAnimationWithDuration: TimeInterval {
        0.15
    }

    var updateLayoutAnimationWithDuration: TimeInterval {
        0.3
    }

    var gravitateAnimationWithDuration: TimeInterval {
        1
    }

    var gravitateSpringWithDampingRatio: CGFloat {
        0.8
    }

    var gravitateSpringWithVelocity: CGFloat {
        0.8
    }
}

public extension FloatingShowable where Self: UIViewController {
    /// Show processing is performed.
    /// If the call is made more than once, please hide it in advance.
    func show() {
        view.layer.shadowColor = shadowColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowRadius = shadowRadius
        view.layer.cornerRadius = cornerRadius
        view.alpha = .zero
        view.subviews.forEach { view in
            if self.view.bounds.size == view.bounds.size {
                view.layer.cornerRadius = cornerRadius
                view.clipsToBounds = true
            }
        }

        updateFrame(position: position)
        window.addSubview(view)

        let sleeve = GestureClosureSleeve<UIPanGestureRecognizer>({ [weak self] gesture in
            self?.onTransition(gesture: gesture)
        })
        let recognizer = UIPanGestureRecognizer(target: sleeve, action: #selector(GestureClosureSleeve.invoke(_:)))
        recognizer.name = "com.akkeylab.lib.FloatingShowable"
        view.addGestureRecognizer(recognizer)
        let key = String(format: "[%d]", arc4random())
        objc_setAssociatedObject(self, key, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

        UIView.animate(
            withDuration: transitionAnimationWithDuration,
            delay: .zero,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.view.alpha = 1
            }
        )
    }

    /// If you change the stayArea and call it, the changes will be applied with animation.
    func updateLayout() {
        view.layer.removeAllAnimations()
        UIView.animate(
            withDuration: updateLayoutAnimationWithDuration,
            delay: .zero,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                let position = self.updatePosition(velocity: self.view.center)
                self.updateFrame(position: position)
            }
        )
    }

    /// Hide processing is performed.
    /// - Parameters:
    ///   - isScaleChange: You can specify whether to perform scale animation when hiding.
    func dismiss(isScaleChange: Bool) {
        view.gestureRecognizers?
            .filter { $0.name == "com.akkeylab.lib.FloatingShowable" }
            .forEach { view.removeGestureRecognizer($0) }

        UIView.animate(
            withDuration: transitionAnimationWithDuration,
            delay: .zero,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.view.alpha = .zero
                if isScaleChange {
                    self?.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }
            },
            completion: { [weak self] _ in
                self?.view.removeFromSuperview()
                if isScaleChange {
                    self?.view.transform = .identity
                }
            }
        )
    }

    private mutating func onTransition(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let center = self.view.center
            let transition = gesture.translation(in: window)
            self.view.center = CGPoint(
                x: center.x + transition.x,
                y: center.y + transition.y
            )
            gesture.setTranslation(.zero, in: window)

        case .ended:
            position = updatePosition(velocity: gesture.velocity(in: nil))
            UIView.animate(
                withDuration: gravitateAnimationWithDuration,
                delay: .zero,
                usingSpringWithDamping: gravitateSpringWithDampingRatio,
                initialSpringVelocity: gravitateSpringWithVelocity,
                options: .curveEaseOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.updateFrame(position: self.position)
                }
            )

        default:
            break
        }
    }

    private func updatePosition(velocity: CGPoint) -> FloatingPosition {
        let safeAreaHeightHalf = (window.frame.height - (window.safeAreaInsets.top + window.safeAreaInsets.bottom)) / 2
        let isTop = view.center.y < window.safeAreaInsets.top + safeAreaHeightHalf
        let isLeft = view.center.x < window.frame.width / 2
        let position: () -> FloatingPosition = {
            switch velocity.direction {
            case .top where isLeft:
                return .topLeft

            case .top, .topRight:
                return .topRight

            case .bottom where isLeft:
                return .bottomLeft

            case .right where isTop:
                return .topRight

            case .right, .bottom, .bottomRight:
                return .bottomRight

            case .left where isTop:
                return .topLeft

            case .left, .bottomLeft:
                return .bottomLeft

            case .topLeft:
                return .topLeft

            case .none where isTop:
                return isLeft ? .topLeft : .topRight

            case .none:
                return isLeft ? .bottomLeft : .bottomRight
            }
        }
        return position()
    }

    private func updateFrame(position: FloatingPosition) {
        var origin: CGPoint = .zero
        let safeAreaInsets = window.safeAreaInsets

        switch position {
        case .topLeft:
            origin.x = safeAreaInsets.left + stayArea.left
            origin.y = safeAreaInsets.top + stayArea.top

        case .bottomLeft:
            origin.x = safeAreaInsets.left + stayArea.left
            origin.y = window.frame.height - safeAreaInsets.bottom - stayArea.bottom - frameSize.height

        case .topRight:
            origin.x = window.frame.width - safeAreaInsets.right - stayArea.right - frameSize.width
            origin.y = safeAreaInsets.top + stayArea.top

        case .bottomRight:
            origin.x = window.frame.width - safeAreaInsets.right - stayArea.right - frameSize.width
            origin.y = window.frame.height - safeAreaInsets.bottom - stayArea.bottom - frameSize.height
        }

        view.frame = CGRect(origin: origin, size: frameSize)
    }
}

private extension CGPoint {
    enum DirectionType {
        case top
        case right
        case bottom
        case left
        case topRight
        case bottomRight
        case topLeft
        case bottomLeft
        case none
    }

    var direction: DirectionType {
        if x.isPositive && y.isNegative {
            return .topRight
        } else if x.isPositive && y.isAboutZero {
            return .right
        } else if x.isPositive && y.isPositive {
            return .bottomRight
        } else if x.isAboutZero && y.isPositive {
            return .bottom
        } else if x.isNegative && y.isPositive {
            return .bottomLeft
        } else if x.isNegative && y.isAboutZero {
            return .left
        } else if x.isNegative && y.isNegative {
            return .topLeft
        } else if x.isAboutZero && y.isNegative {
            return .top
        } else {
            return .none
        }
    }
}

private extension CGFloat {
    enum Const {
        static let minLimit: CGFloat = 500
        static let maxLimit: CGFloat = 700
    }

    var isAboutZero: Bool {
        self < Const.minLimit && self > -Const.minLimit
    }

    var isPositive: Bool {
        self > Const.maxLimit
    }

    var isNegative: Bool {
        self < -Const.maxLimit
    }
}
