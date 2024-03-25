//
//  AgeSelectionViewController.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit
import SnapKit

class AgeSelectionViewController: UIViewController {

    // MARK: - Properties
    let datePicker = UIDatePicker()
    let goToBgVCButton = UIButton()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white

        datePicker.datePickerMode = .date
        view.addSubview(datePicker)

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        goToBgVCButton.setTitle("Select Background Color", for: .normal)
        goToBgVCButton.setTitleColor(.white, for: .normal)
        goToBgVCButton.backgroundColor = .green
        goToBgVCButton.layer.cornerRadius = 15
        goToBgVCButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        goToBgVCButton.addTarget(self, action: #selector(selectGoToBgButtonTapped), for: .touchUpInside)
        view.addSubview(goToBgVCButton)
    }

    // MARK: - Layout
    private func layoutUI() {
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        goToBgVCButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
    }

    // MARK: - Actions
    @objc private func doneButtonTapped() {
        let selectedDate = datePicker.date
        NotificationCenter.default.post(name: .didSelectBirthDate, object: nil, userInfo: ["selectedDate": selectedDate])
        navigationController?.popViewController(animated: true)
    }
    @objc private func selectGoToBgButtonTapped() {
        let bgSelectionVC = BackgroundColorSelectionViewController()
        navigationController?.pushViewController(bgSelectionVC, animated: true)
    }
}

//MARK: Notification
extension Notification.Name {
    static let didSelectBirthDate = Notification.Name("didSelectBirthDate")
}


