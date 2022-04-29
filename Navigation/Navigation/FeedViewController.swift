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
        layout()
    }
    
    private let feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var newPostButtonOne: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Новый пост 1", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(newPostAction), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var newPostButtonTwo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Новый пост 2", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(newPostAction), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc private func newPostAction() {
        let newPostController = PostViewController()
        newPostController.titlePost = post.title
        navigationController?.pushViewController(newPostController, animated: true)
    }
    
    private func layout() {
        view.addSubview(feedStackView)
        [newPostButtonOne,newPostButtonTwo].forEach { feedStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            feedStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        
        ])
    }
    
    
}
