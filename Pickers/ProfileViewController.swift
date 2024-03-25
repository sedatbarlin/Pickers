//
//  ProfileViewController.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    // MARK: - Properties
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let ageLabel = UILabel()
    let selectPhotoButton = UIButton()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileImage(_:)), name: .didSelectPhoto, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelFonts(_:)), name: .didSelectFont, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAgeLabel(_:)), name: .didSelectBirthDate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor(_:)), name: .didSelectBackgroundColor, object: nil)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 20
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.height.equalTo(300)
        }

        nameLabel.text = "Sedat Barlin"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 50)
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
        }

        ageLabel.text = "Select Age"
        ageLabel.textAlignment = .center
        ageLabel.textColor = .black
        ageLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }

        selectPhotoButton.setTitle("Select Photo", for: .normal)
        selectPhotoButton.setTitleColor(.white, for: .normal)
        selectPhotoButton.backgroundColor = .systemIndigo
        selectPhotoButton.layer.cornerRadius = 15
        selectPhotoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectPhotoButton.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
        view.addSubview(selectPhotoButton)
        selectPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }

    // MARK: - Actions
    @objc private func selectPhotoButtonTapped() {
        let photoSelectionVC = PhotoSelectionViewController()
        navigationController?.pushViewController(photoSelectionVC, animated: true)
    }

    // MARK: - Profile Image Change
    @objc private func updateProfileImage(_ notification: Notification) {
        guard let selectedImage = notification.userInfo?["selectedImage"] as? UIImage else { return }
        profileImageView.image = selectedImage
    }
    //MARK: - Font Change
    @objc private func updateLabelFonts(_ notification: Notification) {
        if let selectedFont = notification.userInfo?["selectedFont"] as? UIFont {
            nameLabel.font = selectedFont.withSize(18)
            ageLabel.font = selectedFont.withSize(16)
        }
    }
    // MARK: - Age Change
    @objc private func updateAgeLabel(_ notification: Notification) {
        if let selectedDate = notification.userInfo?["selectedDate"] as? Date {
            let ageComponents = Calendar.current.dateComponents([.year], from: selectedDate, to: Date())
            if let age = ageComponents.year {
                ageLabel.text = "Age: \(age)"
            }
        }
    }
    // MARK: - BackgroundColor Change
    @objc private func updateBackgroundColor(_ notification: Notification) {
        if let selectedColor = notification.userInfo?["selectedColor"] as? UIColor {
            view.backgroundColor = selectedColor
        }
    }
}

extension Notification.Name {
    static let didSelectFont = Notification.Name("didSelectFont")
}
