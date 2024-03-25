//
//  FontSelectionViewController.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit
import SnapKit

class FontSelectionViewController: UIViewController {

    // MARK: - Properties
    let fontLabel = UILabel()
    let fontPickerView = UIPickerView()
    let goToAgeVCButton = UIButton()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white

        fontLabel.text = "Select Font"
        fontLabel.textAlignment = .center
        fontLabel.textColor = .black
        fontLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(fontLabel)

        fontPickerView.delegate = self
        fontPickerView.dataSource = self
        fontPickerView.backgroundColor = .gray
        fontPickerView.layer.cornerRadius = 30
        view.addSubview(fontPickerView)
        
        goToAgeVCButton.setTitle("Select Age", for: .normal)
        goToAgeVCButton.setTitleColor(.white, for: .normal)
        goToAgeVCButton.backgroundColor = .systemIndigo
        goToAgeVCButton.layer.cornerRadius = 15
        goToAgeVCButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        goToAgeVCButton.addTarget(self, action: #selector(selectGoToAgeButtonTapped), for: .touchUpInside)
        view.addSubview(goToAgeVCButton)
    }

    // MARK: - Layout
    private func layoutUI() {
        fontLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
        }
        fontPickerView.snp.makeConstraints { make in
            make.top.equalTo(fontLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        goToAgeVCButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fontPickerView.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }

    
    @objc private func selectGoToAgeButtonTapped() {
        let ageSelectionVC = AgeSelectionViewController()
        navigationController?.pushViewController(ageSelectionVC, animated: true)
    }
    
    // MARK: - NotificationCenter
    private func postFontChangeNotification(selectedFont: UIFont) {
        NotificationCenter.default.post(name: .didSelectFont, object: nil, userInfo: ["selectedFont": selectedFont])
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension FontSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIFont.familyNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedFontName = UIFont.familyNames[row]
        if let selectedFont = UIFont(name: selectedFontName, size: 16) {
            postFontChangeNotification(selectedFont: selectedFont)
        }
    }
}

