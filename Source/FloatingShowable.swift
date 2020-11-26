//
//  FloatingShowable.swift
//  FloatingShowable
//
//  Created by AKIO ITAYA on 2020/11/26.
//

import UIKit

public protocol FloatingShowable {
    var window: UIWindow { get }
    var stayArea: UIEdgeInsets { get }
    var frameSize: CGSize { get }
    var cornerRadius: CGFloat { get }
    var shadowColor: CGColor { get }
    var shadowOpacity: Float { get }
    var shadowOffset: CGSize { get }
    var shadowRadius: CGFloat { get }
    var position: FloatingPosition { get set }
    var transitionAnimationWithDuration: TimeInterval { get }
    var updateLayoutAnimationWithDuration: TimeInterval { get }
    var gravitateAnimationWithDuration: TimeInterval { get }
    var gravitateSpringWithDampingRatio: CGFloat { get }
    var gravitateSpringWithVelocity: CGFloat { get }
}
