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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        floatingScreen.show()
    }
}
