//
//  FloatingShowable.swift
//  FloatingShowable
//
//  Created by AKIO ITAYA on 2020/11/26.
//

import UIKit

public protocol FloatingShowable {
    /// Specify the UIWindow to display View. This View must be FloatingShowable compliant.
    var window: UIWindow { get }
    /// This specifies the movable area.
    /// This area may be temporarily exceeded by gesture movement.
    /// However, the stationary coordinates are determined with reference to this value.
    var stayArea: UIEdgeInsets { get }
    /// This value is the View frame size.
    /// This should be less than the size of the Window you specify as the display area.
    /// You also need to consider the `stayArea` when considering the Window size.
    var frameSize: CGSize { get }
    /// The radius to use when drawing rounded corners for the layer’s background.
    var cornerRadius: CGFloat { get }
    /// The color of the layer’s shadow.
    var shadowColor: CGColor { get }
    /// The opacity of the layer’s shadow.
    var shadowOpacity: Float { get }
    /// The offset (in points) of the layer’s shadow.
    var shadowOffset: CGSize { get }
    /// The blur radius (in points) used to render the layer’s shadow.
    var shadowRadius: CGFloat { get }
    /// This position is used as a stop position.
    /// The position specified at the time of initialization will be the position at the time of initial display.
    var position: FloatingPosition { get set }
    /// This is the duration of the show and hide animation.
    var transitionAnimationWithDuration: TimeInterval { get }
    /// This is the duration of the animation to which the layout change will be applied.
    /// It is used when applying `stayArea` changes.
    var updateLayoutAnimationWithDuration: TimeInterval { get }
    /// This duration is the amount of time that the View will move into place when it leaves your finger.
    var gravitateAnimationWithDuration: TimeInterval { get }
    /// The damping ratio for the spring animation as it approaches its quiescent state.
    var gravitateSpringWithDampingRatio: CGFloat { get }
    /// The initial spring velocity.
    /// For smooth start to the animation, match this value to the view’s velocity as it was prior to attachment.
    var gravitateSpringWithVelocity: CGFloat { get }
}
