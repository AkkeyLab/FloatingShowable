//
//  GestureClosureSleeve.swift
//  FloatingShowable
//
//  Created by AKIO ITAYA on 2020/12/03.
//

import UIKit

final class GestureClosureSleeve<T: UIGestureRecognizer> {
    let closure: (_ gesture: T) -> Void

    init(_ closure: @escaping (_ gesture: T) -> Void) {
        self.closure = closure
    }

    @objc func invoke(_ gesture: Any) {
        guard let gesture = gesture as? T else { return }
        closure(gesture)
    }
}
