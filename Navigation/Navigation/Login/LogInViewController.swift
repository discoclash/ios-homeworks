//
//  LogInViewController.swift
//  Navigation
//
//  Created by G on 12.05.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private let nc = NotificationCenter.default
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let logInImage: UIImageView = {
        $0.image = UIImage(named: "logo")
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let logInSackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 10
        $0.axis = .vertical
        $0.clipsToBounds = true
        $0.distribution = .fillEqually
        $0.spacing = -1
        return $0
    } (UIStackView())
    
    private lazy var loginTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .systemGray6
        $0.placeholder = "Email или телефон"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.textColor = .black
        $0.clearsOnBeginEditing = true
        $0.autocapitalizationType = .none
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.delegate = self
        return $0
    } (UITextField())
    
    private lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .systemGray6
        $0.placeholder = "Пароль"
        $0.isSecureTextEntry = true
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.textColor = .black
        $0.clearsOnBeginEditing = true
        $0.autocapitalizationType = .none
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.delegate = self
        return $0
    } (UITextField())
    
    private let invalidDataLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemRed
        $0.font = .systemFont(ofSize: 12)
        $0.contentMode = .scaleToFill
        $0.isHidden = true
        $0.text = "Введите пароль из 6 символов и более"
        return $0
    }(UILabel())
  
    private lazy var logInButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return $0
    } (UIButton())

    @objc private func logIn() {
        
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        invalidDataLabel.isHidden = true
        if login.isEmpty {
         loginTextField.shakeText()
         }
        if password.isEmpty {
            passwordTextField.shakeText()
         }
        if password.count < 6 && !login.isEmpty {
                invalidDataLabel.isHidden = false
        }
        
        let loginKey = LoginKey()
        if login == loginKey.UserName && password == loginKey.UserPassword {
            let profileViewController = ProfileViewController()
            navigationController?.pushViewController(profileViewController, animated: true)
        } else if !login.isEmpty && !password.isEmpty && password.count >= 6 {
            let alert = UIAlertController(title: "Неверный логин или пароль", message: nil, preferredStyle: .alert)
            let actionAlert = UIAlertAction(title: "ОК", style: .default) { (_) -> Void in }
            alert.addAction(actionAlert)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addTapGestureToHideKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func layout() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [logInImage, logInSackView, invalidDataLabel, logInButton].forEach { contentView.addSubview($0) }
        
        [loginTextField, passwordTextField].forEach { logInSackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logInImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  120),
            logInImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInImage.widthAnchor.constraint(equalToConstant: 100),
            logInImage.heightAnchor.constraint(equalToConstant: 100),
            
            logInSackView.topAnchor.constraint(equalTo: logInImage.bottomAnchor, constant: 120),
            logInSackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInSackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInSackView.heightAnchor.constraint(equalToConstant: 100),
            
            invalidDataLabel.centerYAnchor.constraint(equalTo: logInSackView.bottomAnchor, constant: 8),
            invalidDataLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            logInButton.topAnchor.constraint(equalTo: logInSackView.bottomAnchor, constant:  16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
