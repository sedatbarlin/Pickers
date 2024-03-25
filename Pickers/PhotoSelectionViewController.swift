//
//  PhotoSelectionViewController.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit
import SnapKit

class PhotoSelectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    let selectPhotoButton = UIButton()
    let goToFontVCButton = UIButton()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        selectPhotoButton.setTitle("Select Photo", for: .normal)
        selectPhotoButton.setTitleColor(.white, for: .normal)
        selectPhotoButton.layer.cornerRadius = 15
        selectPhotoButton.backgroundColor = .systemBrown
        selectPhotoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectPhotoButton.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
        view.addSubview(selectPhotoButton)
        
        goToFontVCButton.setTitle("Select Font", for: .normal)
        goToFontVCButton.setTitleColor(.white, for: .normal)
        goToFontVCButton.backgroundColor = .systemIndigo
        goToFontVCButton.layer.cornerRadius = 15
        goToFontVCButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        goToFontVCButton.addTarget(self, action: #selector(selectGoToFontButtonTapped), for: .touchUpInside)
        view.addSubview(goToFontVCButton)
    }

    // MARK: - Layout
    private func layoutUI() {
        selectPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        goToFontVCButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectPhotoButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }

    // MARK: - Actions
    @objc private func selectPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @objc private func selectGoToFontButtonTapped() {
        let fontSelectionVC = FontSelectionViewController()
        navigationController?.pushViewController(fontSelectionVC, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            NotificationCenter.default.post(name: .didSelectPhoto, object: nil, userInfo: ["selectedImage": selectedImage])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let didSelectPhoto = Notification.Name("didSelectPhoto")
}
