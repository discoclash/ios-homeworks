//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by G on 19.04.2022.
//

import UIKit

protocol imageAnimationDelegate: AnyObject {
    func imageExpanded()
    func imageCollapsed()
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: imageAnimationDelegate?
    
    private let profileImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "zhratiko")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        return $0
    }(UIImageView())
    
    private let profileNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Хатико"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
        return $0
    }(UILabel())
    
    private let profileStatusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Когда кушать?"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    private lazy var setStatusTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 15)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.placeholder = "Введите статус"
        $0.textColor = .lightGray
        $0.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        $0.clearsOnBeginEditing = true
        return $0
    }(UITextField())
    
    
    private var statusText = ""
    @objc private func statusTextChanged() {
        if let text = setStatusTextField.text {
        statusText = text
        }
    }
    
    private lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Установить статус", for: .normal)
        $0.backgroundColor = colorSet
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(setStatusFunc), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func setStatusFunc() {
        if statusText != "" {
            profileStatusLabel.text = statusText
            self.endEditing(true)
        } else {
            setStatusTextField.shakeText()
        }
        setStatusTextField.text = ""
        statusText = ""
    }
   
    private lazy var profileImagePosition = profileImage.layer.position
    private lazy var profileImageBounds = profileImage.layer.bounds
    
    // Создал вью - которое будет при тапе на аватар фоном - полупрозрачным
    private let expandProfileView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.alpha = 0.0
        return $0
    }(UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
    
    // Создал кнопку выхода из режима увеличенного просмотра аватарки
    private lazy var collapseProfileImageButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "multiply", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))?.withTintColor(colorSet, renderingMode: .alwaysOriginal), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.alpha = 0.0
        $0.isUserInteractionEnabled = false
        $0.addTarget(self, action: #selector(collapseAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // настраиваем анимацию для аватарки
    private func setupGestures() {
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(tapProfileImage))
        profileImage.addGestureRecognizer(tapGestureImage)
        profileImage.isUserInteractionEnabled = true
    }
    
    private func setupView() {
        [profileNameLabel, profileStatusLabel, setStatusButton, setStatusTextField, expandProfileView, profileImage, collapseProfileImageButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            collapseProfileImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            collapseProfileImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            profileNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            

            profileStatusLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            profileStatusLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -8),
            profileStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            setStatusTextField.leadingAnchor.constraint(equalTo: profileStatusLabel.leadingAnchor),
            setStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 8),
            setStatusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: setStatusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
      ])
    }
    
    @objc private func tapProfileImage() {
        delegate?.imageExpanded()
        self.profileImagePosition = self.profileImage.layer.position
        self.profileImageBounds = self.profileImage.layer.bounds
        UIImageView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            self.profileImage.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            self.profileImage.layer.cornerRadius = 0
            self.expandProfileView.alpha = 0.8
            self.profileImage.isUserInteractionEnabled = false
            self.setStatusButton.isUserInteractionEnabled = false
            self.setStatusTextField.isUserInteractionEnabled = false
            self.layoutIfNeeded()
        } completion: { _ in
            UIImageView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn){
                self.collapseProfileImageButton.alpha = 1
                self.collapseProfileImageButton.isUserInteractionEnabled = true
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func collapseAction() {
        UIImageView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn){
            self.collapseProfileImageButton.alpha = 0.0
        } completion: { _ in
            UIImageView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) { [self] in
                self.profileImage.layer.position = self.profileImagePosition
                self.profileImage.layer.bounds = self.profileImageBounds
                expandProfileView.alpha = 0.0
                profileImage.layer.cornerRadius = 50
                self.profileImage.isUserInteractionEnabled = true
                self.setStatusButton.isUserInteractionEnabled = true
                self.setStatusTextField.isUserInteractionEnabled = true
                delegate?.imageCollapsed()
                layoutIfNeeded()
            }
        }
    }
}
