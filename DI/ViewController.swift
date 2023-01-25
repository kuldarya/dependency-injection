//
//  ViewController.swift
//  DI
//

import UIKit
import MyAppUIKit
import APIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("Tap Me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton() {
        let vc = CoursesViewController(dataFetchable: APICaller.shared)
        present(vc, animated: true)
    }
}

/// `APICaller` already internally conforms to the same func `DataFetchable` requires to conform to.
extension APICaller: DataFetchable {}
