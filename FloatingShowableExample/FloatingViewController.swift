//
//  FloatingViewController.swift
//  FloatingShowableExample
//
//  Created by AKIO ITAYA on 2020/11/27.
//

import FloatingShowable
import UIKit

final class FloatingViewController: UIViewController {
    var position: FloatingPosition = .bottomRight

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}

extension FloatingViewController: FloatingShowable {
    var frameSize: CGSize {
        CGSize(width: 160, height: 90)
    }

    var window: UIWindow {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first ?? UIWindow()
    }
}
