//
//  BackgroundColorSelectionViewController.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit
import SnapKit

class BackgroundColorSelectionViewController: UIViewController {

    // MARK: - Properties
    let colorPicker = UIColorPickerViewController()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        colorPicker.delegate = self
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    // MARK: - Layout
    private func layoutUI() {
        addChild(colorPicker)
        view.addSubview(colorPicker.view)
        colorPicker.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        colorPicker.didMove(toParent: self)
    }

    // MARK: - Actions
    @objc private func doneButtonTapped() {
        let selectedColor = colorPicker.selectedColor
        NotificationCenter.default.post(name: .didSelectBackgroundColor, object: nil, userInfo: ["selectedColor": selectedColor])
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension BackgroundColorSelectionViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
}
extension Notification.Name {
    static let didSelectBackgroundColor = Notification.Name("didSelectBackgroundColor")
}
