//
//  InfoViewController.swift
//  Navigation
//
//  Created by G on 14.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeButton()
    }
    private func makeButton() {
        let button = UIButton (frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Изменить пост", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        button.layer.cornerRadius = 12
        view.addSubview(button)
    }
    
    @objc private func tapAction() {
        let alert = UIAlertController(title: "Опублиуковать пост", message: "Вы точно хотите измиенить пост?", preferredStyle: .alert)
        let addNewPost = UIAlertAction(title: "Изменить", style: .default) { _ in
            self.dismiss(animated: true)
            print("пост будет отредактирован")
        }
        let cancelNewPost = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(addNewPost)
        alert.addAction(cancelNewPost)
        present(alert, animated: true)
    }

}
