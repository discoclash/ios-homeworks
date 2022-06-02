//
//  DetailPostViewController.swift
//  Navigation
//
//  Created by G on 27.05.2022.
//

import UIKit

protocol ReloadTableViewDataDelegate: AnyObject {
    func reloadData()
}

class DetailPostViewController: UIViewController {
    
    weak var delegate: ReloadTableViewDataDelegate?
    
    var indexPath: IndexPath?
    
    var isLiked: Bool = false
    var likes: Int = 0
    
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    let authorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .clear
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    let postImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let  discriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let likesLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    
    let viewsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        layout()
        setupGestures()
    }
    
    private func setupGestures() {
        let tapOnLabel = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        likesLabel.isUserInteractionEnabled = true
        likesLabel.addGestureRecognizer(tapOnLabel)
    }
    
    @objc private func tapLabel() {
        if !isLiked {
            likes += 1
            likesLabel.text = "Лайков: \(likes)"
            likesLabel.textColor = .systemRed
            isLiked.toggle()
            if let i = indexPath {
                postsModel[i.row].likes += 1
                postsModel[i.row].isLiked.toggle()
                print("\(postsModel[i.row].author) - \(postsModel[i.row].likes) лайков")
            }
        } else {
            likes -= 1
            likesLabel.text = "Лайков: \(likes)"
            likesLabel.textColor = .black
            isLiked.toggle()
            if let i = indexPath {
                postsModel[i.row].likes -= 1
                postsModel[i.row].isLiked.toggle()
                print("\(postsModel[i.row].author) - \(postsModel[i.row].likes) лайков")
            }
        }
        delegate?.reloadData()
    }
      
      private func layout() {
        [authorLabel, postImage, discriptionLabel, likesLabel, viewsLabel].forEach { view.addSubview($0) }
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [authorLabel, postImage, discriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 16
        
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
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            discriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            discriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            discriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            likesLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            viewsLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
      
      
      
