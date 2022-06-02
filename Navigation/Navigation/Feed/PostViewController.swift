//
//  PostViewController.swift
//  Navigation
//
//  Created by G on 14.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = "Пост"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.navigationItem.title = titlePost
        makeBarItem()
    }
    
    private func makeBarItem() {
        let barItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(tapAction))
        self.navigationItem.rightBarButtonItem = barItem
    }
    @objc private func tapAction() {
        let addPost = InfoViewController()
        present(addPost, animated: true)
    }
}
