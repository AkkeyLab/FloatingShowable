//
//  ViewController.swift
//  FloatingShowableExample
//
//  Created by AKIO ITAYA on 2020/11/26.
//

import UIKit

final class ViewController: UIViewController {
    private var floatingScreen = FloatingViewController()

    deinit {
        floatingScreen.dismiss(isScaleChange: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        floatingScreen.view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(gestureAction(sender:)))
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        floatingScreen.show()
    }

    @objc func gestureAction(sender: UIPanGestureRecognizer) {
        floatingScreen.onTransition(gesture: sender)
    }
}
