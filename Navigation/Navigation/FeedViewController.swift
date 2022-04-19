//
//  FeedViewController.swift
//  Navigation
//
//  Created by G on 13.04.2022.
//

import UIKit
struct Post {
    var title = "Мой новый пост"
}
class FeedViewController: UIViewController {
    var post = Post()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.backButtonTitle = "Назад"
        makeButton()
    }
    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Новый пост", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(topAction), for: .touchUpInside)
        button.layer.cornerRadius = 12
        view.addSubview(button)
    }
    
    @objc private func topAction() {
        let newPostController = PostViewController()
        newPostController.titlePost = post.title
        navigationController?.pushViewController(newPostController, animated: true)
    }
    
}
