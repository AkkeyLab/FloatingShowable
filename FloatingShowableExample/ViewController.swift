//
//  ViewController.swift
//  FloatingShowableExample
//
//  Created by AKIO ITAYA on 2020/11/26.
//

import UIKit

final class ViewController: UIViewController {
    private var floatingScreen = FloatingViewController()
    private let changeBottomInsetButton = UIButton()
    private let changeVisibleButton = UIButton()
    private var isBottomInsetAdd = false {
        didSet {
            floatingScreen.stayArea.bottom = isBottomInsetAdd ? 100 : 16
            floatingScreen.updateLayout()
        }
    }
    private var isShowFloating = false {
        didSet {
            _ = isShowFloating
                ? floatingScreen.show()
                : floatingScreen.dismiss(isScaleChange: true)
        }
    }

    deinit {
        floatingScreen.dismiss(isScaleChange: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        changeBottomInsetButton.setTitle("Change Bottom Inset", for: .normal)
        changeBottomInsetButton.addTarget(self, action: #selector(changeBottomInset), for: .touchDown)
        stack.addArrangedSubview(changeBottomInsetButton)

        changeVisibleButton.setTitle("Change Visible Floating", for: .normal)
        changeVisibleButton.addTarget(self, action: #selector(changeVisibleFloating), for: .touchDown)
        stack.addArrangedSubview(changeVisibleButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isShowFloating = true
    }

    @objc private func changeBottomInset() {
        isBottomInsetAdd.toggle()
    }

    @objc private func changeVisibleFloating() {
        isShowFloating.toggle()
    }
}
