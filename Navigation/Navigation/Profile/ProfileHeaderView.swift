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
        backgroundColor = .lightGray
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(profileStatus)
        addSubview(setStatusButton)
        addSubview(setStatus)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        imageView.image = UIImage(named: "zhratiko")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    let profileName: UILabel = {
        let label = UILabel(frame: CGRect(x: 132, y: 27, width:227, height:18))
        label.text = "Жратико"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let profileStatus: UILabel = {
        let label = UILabel(frame: CGRect(x: 132, y: 84, width:227, height:14))
        label.text = "Когда кушать?"
    
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let setStatus: UITextField = {
        let textField = UITextField(frame: CGRect(x: 132, y: 106, width: 227, height: 40))
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
        if let text = setStatus.text {
        statusText = text
        }
    }
    
    
    let setStatusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 162, width: 343, height: 50))
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
            profileStatus.text = statusText
        }
        setStatus.text = "Введите статус"
        
    }
   

}
