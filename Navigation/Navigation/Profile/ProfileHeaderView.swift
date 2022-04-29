//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by G on 19.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zhratiko")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Жратико"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let profileStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Когда кушать?"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var setStatusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.text = "Введите статус"
        textField.textColor = . lightGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    
    private var statusText = ""
    @objc private func statusTextChanged() {
        if let text = setStatusTextField.text {
        statusText = text
        }
    }
    
    
    lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Установить статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatusFunc), for: .touchUpInside)
        return button
    }()
    
    @objc private func setStatusFunc() {
        if statusText != "" {
            profileStatusLabel.text = statusText
        }
        setStatusTextField.text = "Введите статус"
        
    }
   
    private func setupView() {
        backgroundColor = .lightGray
        [profileImage, profileNameLabel, profileStatusLabel, setStatusButton, setStatusTextField].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            profileNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            

            profileStatusLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            profileStatusLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -8),
            profileStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            
            setStatusTextField.leadingAnchor.constraint(equalTo: profileStatusLabel.leadingAnchor),
            setStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 8),
            setStatusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: setStatusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
      ])
    }

}
